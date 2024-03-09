output "jenkins_ec2_public_ip" {
  value = "${module.jenkins.jenkins_ec2_public_ip}"
}

output "jenkins_pubkey" {
  value = "${module.jenkins.pub_ssh_key}"
}