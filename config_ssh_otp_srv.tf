
resource "null_resource" "ssh_helper_install" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "file" {
    source      = ("./template/vault_ssh_helper_install.sh")
    destination = ("/root/vault_ssh_helper_install.sh")

    connection {
      type     = "ssh"
      user     = "root"
      password = "Password"
      host     = var.ssh_srv_public_ip
    }
  }

  provisioner "remote-exec" {
    inline = (["chmod +x /root/vault_ssh_helper_install.sh", "/root/vault_ssh_helper_install.sh"])

    connection {
      type     = "ssh"
      user     = "root"
      password = "Password"
      host     = var.ssh_srv_public_ip
    }
  }
    provisioner "file" {
    source      = "./policies/ssh_srv_config.sh"
    destination = "/root/ssh_srv_config.sh"

    connection {
      type     = "ssh"
      user     = "root"
      password = "E4!T6!dHMa"
      host     = var.ssh_srv_public_ip
    }
  }
}


resource "null_resource" "pamd_sshd" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "file" {
    source      = ("./template/sshd_centos")
    destination = ("/root/sshd_otp")

    connection {
      type     = "ssh"
      user     = "root"
      password = "Password"
      host     = var.ssh_srv_public_ip
    }
  }

  provisioner "remote-exec" {
    inline = (["cp /etc/pam.d/sshd /etc/pam.d/sshd_orig", "cp /root/sshd_otp /etc/pam.d/sshd"])

    connection {
      type     = "ssh"
      user     = "root"
      password = "Password"
      host     = var.ssh_srv_public_ip
    }
  }

}
