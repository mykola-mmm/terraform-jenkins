
output "pub_ssh_key" {
  value = aws_key_pair.jenkins_e2_keypair.public_key
}

output "jenkins_ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}