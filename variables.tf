variable "instance_count" {
  default = "2"
}

variable "region" {
  description = "AWS region for hosting our your network"
  default = "eu-west-1"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "terraform_keypair"
}

variable "ami" {
  description = "Base AMI to launch the instances"
  default = "ami-06fd8a495a537da8b"
}
