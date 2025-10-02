terraform {
required_providers {
local = {
source = "hashicorp/local"
version = "~> 2.1"
}
}
}


variable "web_ip" {
type = string
default = "192.168.56.20"
}


resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/hosts.ini"
  content  = <<EOF
[web]
${var.web_ip} ansible_user=vagrant ansible_private_key_file=/home/vagrant/.ssh/id_rsa
EOF
}



# Optional: prueba de conexión SSH desde control-node hacia web-node
resource "null_resource" "test_ssh" {
provisioner "remote-exec" {
inline = ["echo connected_from_terraform > /tmp/terraform_test.txt"]


connection {
type = "ssh"
host = var.web_ip
user = "vagrant"
private_key = file("${path.module}/../ssh_keys/id_rsa")
timeout = "2m"
}
}


depends_on = [local_file.ansible_inventory]
}


output "web_ip" {
value = var.web_ip
}
