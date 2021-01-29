provider "vault" {
  address = var.vault_addr
  # token = var.vault_token
  /*
   Vault token that will be used by Terraform to authenticate.
    May be set via the VAULT_TOKEN environment variable. 
    If none is otherwise supplied, Terraform will attempt to read it from ~/.vault-token (where the vault command stores its current token). 
   */
  namespace = "ns_demo_ncp" # Vault Enterprise 상의 NameSpace 사용을 위한 설정, Vault OSS 사용 시 주석 처리 후 사용
  version = "~> 2.0.0"
}
