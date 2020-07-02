output "acs_pub_ip" {
  value = aws_instance.ACS.*.public_ip
}

output "centosNode_pub_ip" {
  value = aws_instance.Centos-Node.*.public_ip
}

output "UbuntuNode_pub_ip" {
  value = aws_instance.Ubuntu-Node.*.public_ip
}

output "WindowsNode_pub_ip" {
  value = aws_instance.Windows-Node.*.public_ip
}


output "acs_priv_ip" {
  value = aws_instance.ACS.*.private_ip
}

output "centosNode_priv_ip" {
  value = aws_instance.Centos-Node.*.private_ip
}

output "UbuntuNode_priv_ip" {
  value = aws_instance.Ubuntu-Node.*.private_ip
}

output "WindowsNode_priv_ip" {
  value = aws_instance.Windows-Node.*.private_ip
}


