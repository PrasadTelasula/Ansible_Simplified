
data "template_file" "node1" {
        template = file("acs_config/host_vars/node1.tpl")
        vars = {
            centos_node_private_address = aws_instance.Centos-Node.private_ip,
        }
}

data "template_file" "node2" {
        template = file("acs_config/host_vars/node2.tpl")
        vars = {
            ubuntu_node_private_address = aws_instance.Ubuntu-Node.private_ip,
        }
}


data "template_file" "node3" {
        template = "${file("acs_config/host_vars/node3.tpl")}"
        vars = {
            windows_node_private_address = aws_instance.Windows-Node.private_ip,
            windows_password = rsadecrypt(aws_instance.Windows-Node.password_data, file(var.WINDOWS_PRIV_KEY))

        }
}
