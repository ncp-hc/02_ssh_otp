# OTP 사용자를 위한 Vault 정책

path "ssh/creds/otp_key_role" {
  capabilities = ["create", "read", "update"]
}
