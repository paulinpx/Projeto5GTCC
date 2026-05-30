# Deploy feito em um Linux Debian 12

Lab 3: Deploying free5GC

Preparação:

## Instalando GTP5G: 
https://github.com/free5gc/gtp5g

apt -y update
apt -y install git gcc g++ cmake autoconf libtool pkg-config libmnl-dev libyaml-dev bridge-utils build-essential
apt-get -y install linux-headers-$(uname -r)

#Atualize as dependências do kernel:
depmod -a

git clone -b v0.8.10 https://github.com/free5gc/gtp5g.git
cd gtp5g
# Faça o checkout para a tag v0.8.10
git checkout v0.8.10
make
make install

# Verifique a versão do módulo
modinfo gtp5g
# A saída deve mostrar version: 0.8.6

# Verifique se está carregado
lsmod | grep gtp5g



##Instalando Docker:
#Rode o script shell
bash docker_install.sh
