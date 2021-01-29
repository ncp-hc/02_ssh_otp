/*
$ vault secrets enable ssh
Success! Enabled the ssh secrets engine at: ssh/
*/
resource "vault_mount" "ssh" {
  type = "ssh"
  path = "ssh"
}

/* 
$ vault write ssh/roles/otp_key_role key_type=otp \
    default_user=vagrant \
    cidr_list=0.0.0.0/0
Success! Data written to: ssh/roles/otp_key_role
*/

resource "vault_ssh_secret_backend_role" "clt_otp" {
  name          = "otp_key_role"
  backend       = vault_mount.ssh.path
  key_type      = "otp"
  default_user  = "otp_user"
  allowed_users = "otp_user"
  cidr_list     = "0.0.0.0/0"
}


# Apply Policy 
resource "vault_policy" "otp_policy" {
  name = "otp"

  policy = file("policies/otp.hcl")
}


resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

# Create a user, 'otp-user'
resource "vault_generic_endpoint" "otp-user" {
  #depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/otp_user"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["default", "otp"],
  "password": "test"
}
EOT

}
