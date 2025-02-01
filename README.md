# gitFinder

Skrip ini berguna untuk Bug Bounty Hunter, Pentester, dan Admin Keamanan dalam mendeteksi kebocoran repositori Git dengan memeriksa aksesibilitas .git/HEAD pada subdomain target. Jika ditemukan, repositori yang bocor dapat diekstrak menggunakan git-dumper untuk analisis lebih lanjut. 🚀

## Instalasi

Pastikan Anda memiliki package manager yang sesuai dengan sistem Anda:

**Untuk Termux:**
```bash
pkg install -y curl jq golang
```

**Untuk Debian/Ubuntu:**
```bash
sudo apt update && sudo apt install -y curl jq golang
```

**Untuk macOS (Homebrew):**
```bash
brew install curl jq golang
```

Setelah itu, jalankan perintah berikut untuk menginstal dependensi tambahan:
```bash
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
```

Tambahkan Go ke PATH jika belum ada:
```bash
export PATH=$HOME/go/bin:$PATH
```

## Penggunaan

Jalankan skrip dengan perintah berikut:
```bash
./gitFinder.sh target.com
```
Atau tanpa argumen, skrip akan meminta input secara manual:
```bash
./gitFinder.sh
Masukkan domain target (contoh: tesla.com): target.com
```

## Output
Hasil pemindaian akan disimpan di file `results.txt`, yang berisi daftar subdomain yang memiliki `.git/HEAD` terbuka dan bisa diakses.

