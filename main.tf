module "networking" {
  source              = "./networking"
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  cidr_public_subnet  = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  availability_zone  = var.availability_zone
}

module "security_group" {
  source = "./security-group"
  ec2_sg_name = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
  vpc_id = module.networking.main_vpc_id
}

module "jenkins" {
  source = "./jenkins"
  ami_id = "ami-04dfd853d88e818e8"
  instance_type = "t2.micro"
  subnet_id = tolist(module.networking.public_subnets_list)[0]
  jenkins_security_groups_ids = [module.security_group.sg_ec2_sg_ssh_http_https_id, module.security_group.sg_ec2_jenkins_port_8080_id]
  jenkins_enable_public_ip_address = true
  jenkins_tag_name = "Jenkins:Ubuntu Linux EC2"
  jenkins_ec2_keyname = "Jenkins key"
  jenkins_ec2_publickey_location = "./pubkey/jenkins_ed25519.pub"
  user_data_install_jenkins = templatefile("./jenkins-runner-script/jenkins-installer.sh", {})
}