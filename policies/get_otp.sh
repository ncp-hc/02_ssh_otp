#!/bin/bash
export VAULT_ADDR="VAULT서버 주소" # http://vault_server_ip:port 형식으로 지정
vault login -ns=ns_demo_ncp -no-print -method=userpass -format=json username=otp_user password=test # Vault 접속을 위한 User Name / Password
vault write -ns=ns_demo_ncp -field=key ssh/creds/otp_key_role ip=<접석 대상 서버 IP> > otp_number
echo "otp-number : $(cat otp_number) "
