output "sg_ec2_sg_ssh_http_https_id" {
  value = aws_security_group.ec2_sg_ssh_http_https.id
}

output "sg_ec2_jenkins_port_8080_id" {
  value = aws_security_group.ec2_sg_jenkins_8080.id
}