#!/bin/bash

# Warna untuk output
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Deteksi package manager
if command -v pkg &> /dev/null; then
    PM="pkg install -y"
elif command -v apt &> /dev/null; then
    PM="sudo apt install -y"
elif command -v brew &> /dev/null; then
    PM="brew install"
else
    echo -e "${RED}[-] Package manager tidak ditemukan! Install dependencies secara manual.${RESET}"
    exit 1
fi

# Cek dan install Go jika belum ada
if ! command -v go &> /dev/null; then
    echo -e "${RED}[-] Go tidak ditemukan. Menginstal...${RESET}"
    $PM golang
    export PATH=$HOME/go/bin:$PATH
fi

# Pastikan Go sudah bisa digunakan
export PATH=$HOME/go/bin:$PATH

# Daftar alat yang diperlukan
tools=("curl" "jq" "assetfinder" "anew" "httpx")

# Cek dan install alat yang belum ada
echo -e "${YELLOW}[+] Mengecek dependencies...${RESET}"
for tool in "${tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        echo -e "${RED}[-] $tool tidak ditemukan. Menginstal...${RESET}"
        case "$tool" in
            "curl"|"jq")
                $PM "$tool"
                ;;
            "assetfinder")
                go install -v github.com/tomnomnom/assetfinder@latest
                ;;
            "anew")
                go install -v github.com/tomnomnom/anew@latest
                ;;
            "httpx")
                go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
                ;;
        esac
    else
        echo -e "${GREEN}[✓] $tool sudah terinstal.${RESET}"
    fi
done

# Pastikan semua tools dari Go tersedia
export PATH=$HOME/go/bin:$PATH

# Meminta domain dari user jika tidak diberikan sebagai argumen
if [ -z "$1" ]; then
    read -p "Masukkan domain target (contoh: tesla.com): " DOMAIN
else
    DOMAIN="$1"
fi

# Jalankan perintah untuk mencari subdomain dengan .git/HEAD yang bisa diakses
echo -e "${YELLOW}[+] Mencari subdomain dengan .git/HEAD yang terbuka untuk $DOMAIN...${RESET}"

curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | \
    jq -r '.[].name_value' | \
    assetfinder -subs-only | \
    sed 's#$#/.git/HEAD#g' | \
    httpx -silent -content-length -status-code 301,302 -timeout 3 -retries 0 -ports 80,8080,443 -threads 500 -title | \
    anew results.txt

echo -e "${GREEN}[✓] Pengecekan selesai. Hasil disimpan di 'results.txt'.${RESET}"

