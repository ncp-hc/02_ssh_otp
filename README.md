# 02_ssh_otp
NCP에 배포된 Baremetal 서버 접속을 위한 SSH OTP 생성용 코드


## 실행 순서

1. Code Download 또는 Clone
2. Vault 서버 주소와 대상 서버 주소값 변경
3. CLI 상의 환경 변수로 VAULT_ADDR 및 VAULT_TOKEN 설정
4. CLI 상에서, terraform init --> terraform apply
5. CLI 상에서 sh ./policies/get_otp.sh 를 실행하여 otp 번호 확인 후 대상 서버 접속
