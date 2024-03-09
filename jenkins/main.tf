variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "jenkins_security_groups_ids" {}
variable "jenkins_enable_public_ip_address" {}
variable "jenkins_tag_name" {}
variable "jenkins_ec2_keyname" {}
variable "jenkins_ec2_publickey_location" {}
variable "user_data_install_jenkins" {}

resource "aws_instance" "jenkins_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.jenkins_ec2_keyname
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.jenkins_security_groups_ids
  associate_public_ip_address = var.jenkins_enable_public_ip_address

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }

  tags = {
    Name = var.jenkins_tag_name
  }
}

data "local_file" "public_key" {
  filename = var.jenkins_ec2_publickey_location
}

resource "aws_key_pair" "jenkins_e2_keypair" {
  key_name = var.jenkins_ec2_keyname
  public_key = data.local_file.public_key.content
}
