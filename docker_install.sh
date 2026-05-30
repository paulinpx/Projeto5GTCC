#!/usr/bin/env bash

#-------------------------------------------------------------
# Author:       Paulo R. Nicacio <paulinho.ricardi2@gmail.com>
# Date:         22-05-2025
# Updates:      xx-xx-xxxx
#-------------------------------------------------------------

set -e  # Para o script em caso de erro

echo "[INFO] Atualizando pacotes e instalando utilitários..."
apt update && apt install -y \
    curl \
    htop \
    dnsutils \
    net-tools \
    traceroute \
    bash-completion \
    systemd-timesyncd \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    resolvconf \
    gnupg \
    lsb-release \
    sudo

resolvconf -u

echo "[INFO] Adicionando chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "[INFO] Adicionando repositório oficial do Docker..."
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

echo "[INFO] Instalando Docker Engine..."
apt install -y docker-ce docker-ce-cli containerd.io

echo "[INFO] Adicionando usuário atual ao grupo docker..."
usermod -aG docker "${SUDO_USER:-$USER}"

echo "[INFO] Habilitando e iniciando o serviço Docker..."
systemctl enable docker
systemctl start docker

echo "[INFO] Docker instalado com sucesso!"
