import pymysql
import pymysql.cursors
from tabulate import tabulate
import sys
import getpass

# KONFIGURASI DATABASE
db_config = {
    'host': 'localhost',
    'database': 'cs_ticket',
    'port': 3307,
    'user': 'root',      
    'password': 'root', 
    'cursorclass': pymysql.cursors.DictCursor,
    'autocommit': True   
}

def connect_db():
    try:
        conn = pymysql.connect(**db_config)
        return conn
    except pymysql.Error as e:
        print(f"[KONEKSI ERROR] {e}")
        return None

# HELPERS (Fungsi Bantuan Tampilan)

def print_header(text):
    print(f"\n{'='*50}")
    print(f" {text}")
    print(f"{'='*50}")

def fetch_and_print(cursor, query, params=None, title="DATA"):
    try:
        if query:
            cursor.execute(query, params)
            
        result = cursor.fetchall()
        
        if not result:
            print(f"\n[INFO] Data '{title}' kosong/tidak ditemukan.")
            return False
            
        print(f"\n--- TABEL: {title} ---")
        formatted_data = []
        for row in result:
            new_row = {}
            for key, val in row.items():
                val_str = str(val)
                if len(val_str) > 50:
                    new_row[key] = val_str[:47] + "..."
                else:
                    new_row[key] = val_str
            formatted_data.append(new_row)
            
        print(tabulate(formatted_data, headers="keys", tablefmt="simple_grid"))
        return True
    except pymysql.Error as e:
        print(f"[ERROR QUERY] {e}")
        return False

# FITUR VIEW (READ DATA)

def show_logs(conn):
    cursor = conn.cursor()
    query = "SELECT * FROM v_history_logs_readable ORDER BY created_at DESC LIMIT 20"
    fetch_and_print(cursor, query, title="20 Aktivitas Terakhir (Logs)")
    cursor.close()

def show_departments(conn):
    cursor = conn.cursor()
    fetch_and_print(cursor, "SELECT id, name FROM departments", title="Daftar Departemen")
    cursor.close()

def show_topics(conn):
    cursor = conn.cursor()
    fetch_and_print(cursor, "SELECT id, topic_name FROM help_topic", title="Daftar Topik Bantuan")
    cursor.close()

def show_agents(conn):
    cursor = conn.cursor()
    query = """
        SELECT u.id, u.name, u.email, 
               (SELECT COUNT(*) FROM ticket_details WHERE agent_id = u.id AND status='process') as workload
        FROM users u 
        JOIN roles r ON u.role_id = r.id 
        WHERE r.name LIKE '%Agent%'
    """
    fetch_and_print(cursor, query, title="Daftar Agent Tersedia")
    cursor.close()

def show_tickets(conn, filter_user_id=None, role_name=None, status_filter=None):
    cursor = conn.cursor()
    query = "SELECT ticket_id, subject, status, client_name, agent_name, created_at FROM v_ticket_complete_info"
    params = []
    conditions = []

    if role_name == 'Client' and filter_user_id:
        conditions.append("client_name = (SELECT name FROM users WHERE id = %s)")
        params.append(filter_user_id)
    
    if status_filter:
        if isinstance(status_filter, list):
            placeholders = ', '.join(['%s'] * len(status_filter))
            conditions.append(f"status IN ({placeholders})")
            params.extend(status_filter)
        else:
            conditions.append("status = %s")
            params.append(status_filter)

    if conditions:
        query += " WHERE " + " AND ".join(conditions)
    
    query += " ORDER BY created_at DESC"
    
    title_status = status_filter if status_filter else 'SEMUA'
    title = f"Tiket ({title_status})"
    
    fetch_and_print(cursor, query, params, title=title)
    cursor.close()

def show_ticket_details_raw(conn, ticket_id):
    cursor = conn.cursor()
    query = "SELECT subject, details FROM ticket_details WHERE id = %s"
    cursor.execute(query, (ticket_id,))
    data = cursor.fetchone()
    if data:
        print_header(f"DETAIL TIKET #{ticket_id}")
        print(f"Subject: {data['subject']}")
        print(f"Isi/Percakapan:\n{'-'*20}\n{data['details']}\n{'-'*20}")
        return True
    else:
        print("[ERROR] Tiket tidak ditemukan.")
        return False
    cursor.close()

# FITUR TRANSAKSI (INPUT DATA)

def create_new_ticket(conn, client_id):
    print_header("BUAT TIKET BARU")
    
    show_departments(conn)
    dept_id = input("\n[INPUT] Masukkan ID Departemen: ")
    
    show_topics(conn)
    topic_id = input("[INPUT] Masukkan ID Topik: ")
    
    print("\n--- Isi Detail ---")
    subject = input("Judul Masalah : ")
    details = input("Detail Keluhan: ")
    
    cursor = conn.cursor()
    try:
        args = (client_id, subject, details, dept_id, topic_id)
        cursor.callproc('sp_create_ticket', args)
        conn.commit()
        cursor.execute("SELECT LAST_INSERT_ID() as id")
        res = cursor.fetchone()
        print(f"\n[SUKSES] Tiket berhasil dibuat! ID Tiket: {res['id']}")
    except pymysql.Error as e:
        print(f"[ERROR] {e}")
    finally:
        cursor.close()

def assign_ticket(conn):
    print_header("ASSIGN TIKET KE AGENT")
    
    print("Langkah 1: Pilih Tiket yang belum dihandle")
    show_tickets(conn, status_filter='open')
    
    ticket_id = input("\n[INPUT] Masukkan ID Tiket yang mau di-assign: ")
    
    print("\nLangkah 2: Pilih Agent yang akan mengerjakan")
    show_agents(conn)
    
    agent_id = input("\n[INPUT] Masukkan ID Agent dari tabel di atas: ")
    
    cursor = conn.cursor()
    try:
        args = (ticket_id, agent_id)
        cursor.callproc('sp_assign_agent', args)
        conn.commit()
        res = cursor.fetchall() 
        if res:
            print(f"\n[SUKSES] {list(res[0].values())[0]}")
        else:
            print("\n[SUKSES] Agent berhasil ditugaskan.")
    except pymysql.Error as e:
        print(f"[ERROR] {e}")
    finally:
        cursor.close()

def reply_ticket(conn, user_id, user_role):
    print_header("BALAS TIKET")
    
    if user_role == "Client":
        show_tickets(conn, filter_user_id=user_id, role_name=user_role)
    else:
        show_tickets(conn)
    
    t_id = input("\n[INPUT] Masukkan ID Tiket yang mau dibalas: ")
    
    if user_role == 'Client':
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM ticket_details WHERE id = %s AND client_id = %s", (t_id, user_id))
        check = cursor.fetchone()
        cursor.close()
        
        if not check:
            print("\n[AKSES DITOLAK] Tiket ini bukan milik Anda! Anda tidak bisa membalasnya.")
            return
    
    found = show_ticket_details_raw(conn, t_id)
    if not found: return

    msg = input("\n[INPUT] Tulis balasan Anda: ")
    
    cursor = conn.cursor()
    try:
        args = (t_id, user_id, msg)
        cursor.callproc('sp_reply_ticket', args)
        conn.commit()
        print("\n[SUKSES] Balasan terkirim.")
    except pymysql.Error as e:
        print(f"[ERROR] {e}")
    finally:
        cursor.close()

def close_ticket(conn, user_id, user_role):
    print_header("TUTUP TIKET (CLOSE)")
    
    if user_role == "Client":
        show_tickets(conn, filter_user_id=user_id, role_name=user_role, status_filter=['open', 'process'])
    else:
        show_tickets(conn, status_filter='process')
        
    ticket_id = input("\n[INPUT] Masukkan ID Tiket yang mau di-CLOSE: ")
    
    if user_role == 'Client':
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM ticket_details WHERE id = %s AND client_id = %s", (ticket_id, user_id))
        check = cursor.fetchone()
        cursor.close()
        
        if not check:
            print("\n[AKSES DITOLAK] Tiket ini bukan milik Anda! Anda tidak bisa menutupnya.")
            return
    
    cursor = conn.cursor()
    try:
        args = (ticket_id, user_id)
        cursor.callproc('sp_close_ticket', args)
        conn.commit()
        
        result = cursor.fetchall()
        if result:
             print(f"\n[SUKSES] {list(result[0].values())[0]}")
        else:
            print("\n[SUKSES] Tiket berhasil ditutup.")
            
    except pymysql.Error as e:
        print(f"[ERROR] {e}")
    finally:
        cursor.close()

# MAIN MENU

def login(conn):
    print_header("LOGIN SISTEM")
    email = input("Email: ")
    password = getpass.getpass("Password: ") 

    cursor = conn.cursor()
    query = "SELECT u.id, u.name, r.name as role_name FROM users u JOIN roles r ON u.role_id = r.id WHERE u.email = %s"
    cursor.execute(query, (email,))
    user = cursor.fetchone()
    cursor.close()

    if user:
        print(f"\nSelamat datang, {user['name']} ({user['role_name']})")
        return user
    else:
        print("[ERROR] Login gagal.")
        return None

def main_menu():
    conn = connect_db()
    if not conn: return

    while True:
        user = login(conn)
        if user:
            while True:
                print(f"\nUser: {user['name']} | Role: {user['role_name']}")
                print("-" * 40)
                
                if user['role_name'] == 'Client':
                    print("1. Lihat Tiket Saya")
                    print("2. Buat Tiket Baru")
                    print("3. Balas / Update Tiket")
                    print("4. Tutup Tiket Saya")
                    print("0. Logout")
                    
                    choice = input("Pilih: ")
                    if choice == '1': show_tickets(conn, user['id'], 'Client')
                    elif choice == '2': create_new_ticket(conn, user['id'])
                    elif choice == '3': reply_ticket(conn, user['id'], user['role_name'])
                    elif choice == '4': close_ticket(conn, user['id'], user['role_name'])
                    elif choice == '0': break

                elif user['role_name'] == 'Administrator':
                    print("1. Dashboard & Stats")
                    print("2. Log Aktivitas Sistem")
                    print("3. Kelola Tiket (Assign Agent)")
                    print("4. Lihat Semua Tiket")
                    print("0. Logout")
                    
                    choice = input("Pilih: ")
                    if choice == '1': 
                        cursor = conn.cursor()
                        cursor.callproc('sp_dashboard_stats')
                        fetch_and_print(cursor, None, title="Stats") 
                        cursor.close()
                    elif choice == '2': show_logs(conn)
                    elif choice == '3': assign_ticket(conn)
                    elif choice == '4': show_tickets(conn)
                    elif choice == '0': break

                else: 
                    print("1. Lihat Tiket Masuk")
                    print("2. Ambil Tiket (Self Assign)")
                    print("3. Balas Tiket")
                    print("4. Tutup Tiket")
                    print("0. Logout")
                    
                    choice = input("Pilih: ")
                    if choice == '1': show_tickets(conn)
                    elif choice == '2': assign_ticket(conn)
                    elif choice == '3': reply_ticket(conn, user['id'], user['role_name'])
                    elif choice == '4': close_ticket(conn, user['id'], user['role_name'])
                    elif choice == '0': break
        
        continu = input("\nLogin ulang? (y/n): ")
        if continu.lower() != 'y': break
            
    conn.close()

if __name__ == "__main__":
    main_menu()