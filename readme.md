# Panduan Penggunaan

1. Clone repositori ini dengan `
git clone https://github.com/mcqeems/cs-ticket-mid.git`
2. Kemudian jalankan `pip install -r requirements.txt`
3. Sebelum menjalankan program pastikan anda sudah mengimport database dengan perintah `mysql -u username -p nama_database < cs_ticket-202511241005.sql
`
4. Apabila database sudah berjalan konfigurasi koneksi ke database di dalam kode `cs_ticket.py`

   ```
    db_config = {
    'host': 'localhost',
    'database': 'cs_ticket',
    'port': 3307,
    'user': 'root',
    'password': 'root',
    'cursorclass': pymysql.cursors.DictCursor,
    'autocommit': True
    }


   ```

5. Jalankan program dengan `python cs_ticket.py`

> ### Ini untuk konfigurasi python global apabila dengan venv atau virtual environment maka berbeda cara menjalankannya.
