# 사용 시 sshpass가 설치되어 있어, Environmnet Variables로 VAULT_ADDR와 VAULT_TOKEN이 설정되어 있어야 함.

vault ssh -ns=ns_demo_ncp -role otp_key_role -mode otp -strict-host-key-checking=no otp_user@<접속 대상 서버 IP>
