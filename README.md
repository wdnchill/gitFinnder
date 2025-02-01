# gitFinder

## 📌 Deskripsi
**gitFinder** adalah skrip Bash yang digunakan untuk mendeteksi kebocoran repositori Git pada subdomain target dengan memeriksa aksesibilitas `.git/HEAD`. Skrip ini sangat berguna bagi **Bug Bounty Hunter, Pentester, dan Admin Keamanan** untuk mengidentifikasi celah keamanan yang disebabkan oleh repositori Git yang terekspos.

Jika ditemukan `.git/HEAD` yang dapat diakses, repositori yang bocor dapat diekstrak menggunakan **git-dumper** untuk analisis lebih lanjut. 🚀

---

## 🛠 Instalasi
Sebelum menjalankan **gitFinder**, pastikan Anda memiliki dependencies berikut:
- **curl**
- **jq**
- **assetfinder**
- **httpx**
- **anew**
- **git-dumper** (opsional untuk ekstraksi repositori)

### **1️⃣ Clone Repository**
```bash
git clone https://github.com/username/gitFinder.git
cd gitFinder
chmod +x recon_git_checker.sh
```

### **2️⃣ Instal Dependencies (Jika Belum Terinstal)**
Jalankan perintah berikut untuk menginstal dependencies yang diperlukan:
```bash
sudo apt update && sudo apt install curl jq
GO111MODULE=on go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
export PATH=$HOME/go/bin:$PATH
```
Unduh **assetfinder** dan **anew** secara manual:
```bash
wget https://github.com/tomnomnom/assetfinder/releases/latest/download/assetfinder-linux-amd64 -O assetfinder
chmod +x assetfinder
sudo mv assetfinder /usr/local/bin/

git clone https://github.com/tomnomnom/anew.git
cd anew && go build
sudo mv anew /usr/local/bin/
```
Instal **git-dumper** jika ingin mengekstrak repositori yang ditemukan:
```bash
git clone https://github.com/arthaud/git-dumper.git
cd git-dumper && chmod +x git_dumper.py
```

---

## 🚀 Penggunaan
### **1️⃣ Jalankan Skrip**
```bash
./recon_git_checker.sh
```

### **2️⃣ Masukkan Domain Target**
```bash
Masukkan domain target (contoh: tesla.com): lkpp.go.id
```

### **3️⃣ Tunggu Proses Selesai**
Skrip akan:
✅ Mengumpulkan subdomain dari **crt.sh** dan **assetfinder**
✅ Menambahkan path `/.git/HEAD` pada setiap subdomain
✅ Menggunakan **httpx** untuk mengecek apakah `.git/HEAD` bisa diakses
✅ Menyimpan hasil ke **results.txt**

### **4️⃣ Cek Hasil**
Jika ditemukan subdomain dengan `.git/HEAD` yang dapat diakses:
```bash
cat results.txt
```

### **5️⃣ (Opsional) Ekstrak Repositori Git yang Bocor**
Jika ada `.git/HEAD` yang terbuka, gunakan **git-dumper** untuk mengekstraknya:
```bash
python3 git-dumper/git_dumper.py https://target.com/.git/ output_folder
```

---

## 📜 Contoh Output
```bash
[✓] Mencari subdomain dengan .git/HEAD yang terbuka...
https://dev.target.com/.git/HEAD [200]
https://staging.target.com/.git/HEAD [301]
https://backup.target.com/.git/HEAD [302]
[✓] Pengecekan selesai. Hasil disimpan di 'results.txt'.
```

---

## ⚠ Disclaimer
**Skrip ini hanya boleh digunakan untuk tujuan legal seperti pentesting dan audit keamanan atas izin pemilik sistem. Penyalahgunaan skrip ini dapat melanggar hukum dan kebijakan privasi. Gunakan dengan bijak!**

---

## 📧 Kontak
Jika ada pertanyaan atau ingin berkontribusi, silakan hubungi **[email@example.com](mailto:email@example.com)** atau buat issue di GitHub repository ini.

---

Happy Hacking! 🚀

