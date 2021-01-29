#!/bin/bash
set -x

echo "Running"
USER = "root"
GROUP = "root"
VAULT_VERSION="0.2.0"
VAULT_ZIP=vault-ssh-helper_${VAULT_VERSION}_linux_amd64.zip
VAULT_URL=${URL:-https://releases.hashicorp.com/vault-ssh-helper/${VAULT_VERSION}/${VAULT_ZIP}}
VAULT_DIR=/usr/local/bin
VAULT_PATH=${VAULT_DIR}/vault-ssh-helper
VAULT_CONFIG_DIR=/etc/vault-ssh-helper.d
#VAULT_DATA_DIR=/opt/vault/data
#VAULT_TLS_DIR=/opt/vault/tls
VAULT_ENV_VARS=${VAULT_CONFIG_DIR}/config.hcl


echo "Downloading Vault SSH Helper ${VAULT_VERSION}"
[ 200 -ne $(curl --write-out %{http_code} --silent --output /tmp/${VAULT_ZIP} ${VAULT_URL}) ] && exit 1

echo "Installing Vault SSH Helper"
sudo mkdir ${VAULT_CONFIG_DIR}
sudo apt-get install unzip -y
sudo unzip -o /tmp/${VAULT_ZIP} -d ${VAULT_DIR}
sudo chmod 0755 ${VAULT_PATH}
sudo chown ${USER}:${GROUP} ${VAULT_PATH}
echo "$(${VAULT_PATH} -verify-only)"

echo "Configuring Vault-SSH-Helper ${VAULT_VERSION}"
# 사용 시 Vault_Addr는 변경 필요
sudo tee ${VAULT_ENV_VARS} <<EOF
vault_addr = "http://VAULT_서버_IP:port" 
namespace = "ns_demo_ncp"
tls_skip_verify = true
#ca_cert = "/etc/vault-ssh-helper.d/vault.crt"  --> TLS 적용 시 지정
ssh_mount_point = "ssh"
allowed_roles = "*"
allowed_cidr_list="0.0.0.0/0"
EOF
sudo mkdir -pm 0755 ${VAULT_CONFIG_DIR}

echo "Complete"
