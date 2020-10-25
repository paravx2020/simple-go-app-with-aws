# region / vpc etc

provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  default = true
}

# SG for instances
resource "aws_security_group" "ubuntu" {
  name        = "ubuntu-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8484
    to_port     = 8484
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform"
  }
}

# Creation of app instances
resource "aws_instance" "myInstance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Terraformed = "true"
    Name        = "dev"
  }

  vpc_security_group_ids = [
    aws_security_group.ubuntu.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/terraform_keypair.pem")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "src/steeleye-app.go"
    destination = "~/steeleye-app.go"
  }

  provisioner "file" {
    source      = "setup.sh"
    destination = "~/setup.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x setup.sh",
      "chmod +x steeleye-app.go",
      "touch /tmp/install.log",
      "sh setup.sh > /tmp/install.log",
      "sleep 30",
    ]
  }

}
# output the DNS names for instances
output "DNS" {
  value = join(" and ", aws_instance.myInstance[*].public_dns)
}


