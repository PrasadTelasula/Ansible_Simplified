# Provision Ansible Controller Server with centos 7.
resource "aws_instance" "ACS" {
    ami = var.ACS_AMI_ID
    instance_type = "t2.micro"
    subnet_id = var.SUBNETID
    vpc_security_group_ids = [aws_security_group.acs-sg.id]
    key_name = aws_key_pair.acsKeyPair.key_name
    tags = {
        Name = "ACS"
    }
    
    depends_on = [
        aws_instance.Windows-Node,
    ]
 
    # Connection to execute the file & remote-exec provisioners.
    connection {
            host = self.public_ip
            type     = "ssh"
            user     = "centos"
            private_key = file("keys/acsLaunchKey")
    }

    # Copy Centos Node SSH Private key file to ACS at home directory.
    provisioner "file" {
        source      = "keys/centosLaunchKey"
        destination = "/home/centos/centosLaunchKey"
    }

    # Copy Ubuntu Node SSH Private key file to ACS at home directory.
    provisioner "file" {
        source      = "keys/ubuntuLaunchKey"
        destination = "/home/centos/ubuntuLaunchKey"
    }
    # Assign 400 permissions for Centos & Ubuntu SSH Private Key files.
    provisioner "remote-exec" {
        inline = [
            "chmod 400 /home/centos/centosLaunchKey",
            "chmod 400 /home/centos/ubuntuLaunchKey",
        ]
    }

    # Install pywinrm (dependency package to communicate with windows servers).
    provisioner "remote-exec" {
        inline = [
            #"sudo yum update -y",
            "sudo yum install python-setuptools -y",
            "sudo yum install python-devel -y",
            "sudo yum install epel-release vim wget git -y",
            "sudo yum install -y ansible",
            "sudo yum install nc -y",
            "sudo easy_install pip",
            "pip install pywinrm --user",
            "touch /home/centos/inventory",
            "mkdir -p /home/centos/host_vars"   
        ]
    }


    provisioner "file" {
        source      = "acs_config/ansible.cfg"
        destination = "/home/centos/ansible.cfg"
    }


    provisioner "file" {
        source      = "acs_config/inventory"
        destination = "/home/centos/inventory"
    }

    provisioner "file" {
        content      = data.template_file.node1.rendered
        destination = "/home/centos/host_vars/node1"
    }

    provisioner "file" {
        content      = data.template_file.node2.rendered
        destination = "/home/centos/host_vars/node2"
    }

    provisioner "file" {
        content      = data.template_file.node3.rendered
        destination = "/home/centos/host_vars/node3"
    }

    provisioner "file" {
        source      = "acs_config/group_vars"
        destination = "/home/centos"
    }
}

# Provision Centos Node.
resource "aws_instance" "Centos-Node" {
    ami = var.CENTOS_AMI_ID
    instance_type = "t2.micro"
    subnet_id = var.SUBNETID
    vpc_security_group_ids = [aws_security_group.centos-sg.id]
    key_name = aws_key_pair.centosKeyPair.key_name
    tags = {
        Name = "CentosNode",
        OS = "Centos"
    }
  
}

# Provision Ubuntu Node.
resource "aws_instance" "Ubuntu-Node" {
    ami = var.UBUNTU_AMI_ID
    instance_type = "t2.micro"
    subnet_id = var.SUBNETID
    vpc_security_group_ids = [aws_security_group.ubuntu-sg.id]
    key_name = aws_key_pair.ubuntuKeyPair.key_name
    tags = {
        Name = "UbuntuNode",
        OS = "Ubuntu"
    }
}

# Provision Windows Node.
resource "aws_instance" "Windows-Node"{
    ami = var.WINDOWS_AMI_ID
    instance_type = "t2.medium"
    subnet_id = var.SUBNETID
    vpc_security_group_ids = [aws_security_group.windows-sg.id]
    key_name = aws_key_pair.windowsKeyPair.key_name
    get_password_data = true
    tags = {
        Name = "WindowsNode",
        OS = "Windows"
    }
    user_data = file("win_config/windowsprep.ps1")
}




