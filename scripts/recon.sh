
#!/usr/bin/env bash

# ==========================================
# BRUTE FORCE SECURITY LAB
# Script: Reconhecimento inicial
# Ferramentas: Linux + Nmap
# Uso exclusivo em laboratório autorizado
# ==========================================

set -u

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar argumento
if [[ $# -ne 1 ]]; then
    echo -e "${YELLOW}Uso: $0 IP_DO_ALVO${NC}"
    echo "Exemplo: $0 192.168.56.102"
    exit 1
fi

TARGET="$1"

# Validar IPv4
if ! [[ "$TARGET" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo -e "${RED}[ERRO] Informe um endereço IPv4 válido.${NC}"
    exit 1
fi

if ! command -v nmap >/dev/null 2>&1; then
    echo -e "${RED}[ERRO] Nmap não está instalado.${NC}"
    exit 1
fi

# Criar diretório de resultados
DATE=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="results/recon_$DATE"

mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}"
echo "=========================================="
echo "       BRUTE FORCE SECURITY LAB"
echo "          RECONNAISSANCE"
echo "=========================================="
echo -e "${NC}"

# Informações locais
echo -e "${GREEN}[1] Informações da máquina local${NC}"

{
    echo "Data: $(date)"
    echo "Hostname: $(hostname)"
    echo "Sistema: $(uname -a)"
    echo
    echo "Interfaces de rede:"
    ip -br address
} | tee "$OUTPUT_DIR/local_info.txt"

# Verificar conectividade
echo
echo -e "${GREEN}[2] Verificando conectividade${NC}"

if ping -c 2 -W 2 "$TARGET" > "$OUTPUT_DIR/connectivity.txt" 2>&1; then
    echo -e "${GREEN}[OK] Alvo respondeu ao ping.${NC}"
else
    echo -e "${YELLOW}[AVISO] Alvo não respondeu ao ping.${NC}"
    echo "Isso não significa necessariamente que esteja desligado."
fi

# Reconhecimento de portas e serviços
echo
echo -e "${GREEN}[3] Identificando portas e serviços${NC}"

nmap -sV --top-ports 1000 -T3 \
    -oN "$OUTPUT_DIR/nmap_services.txt" \
    "$TARGET"

# Resumo
echo
echo -e "${GREEN}[4] Finalizando reconhecimento${NC}"

echo "Alvo: $TARGET" > "$OUTPUT_DIR/summary.txt"
echo "Data: $(date)" >> "$OUTPUT_DIR/summary.txt"
echo "Resultado Nmap: nmap_services.txt" >> "$OUTPUT_DIR/summary.txt"

echo
echo -e "${BLUE}=========================================="
echo "RECONHECIMENTO CONCLUÍDO"
echo "==========================================${NC}"

echo -e "${GREEN}Resultados salvos em:${NC} $OUTPUT_DIR"
echo "Arquivos:"
ls -lh "$OUTPUT_DIR"
