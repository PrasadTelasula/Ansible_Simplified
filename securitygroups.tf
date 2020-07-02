resource "aws_security_group" "acs-sg" {
    vpc_id = var.VPCID
    name = "acsSG"
    description = "Security group for Ansible Controler Server"
tags = {
    Name = "acsSG"
}
}

resource "aws_security_group" "centos-sg" {
    vpc_id = var.VPCID
    name = "CentosNodeSG"
    description = "Security group for Centos Node"
tags = {
    Name = "CentosNodeSG"
}
}

resource "aws_security_group" "ubuntu-sg" {
    vpc_id = var.VPCID
    name = "UbuntuNodeSG"
    description = "Security group for Ubuntu Node"
tags = {
    Name = "UbuntuNodeSG"
}
}


resource "aws_security_group" "windows-sg" {
    vpc_id = var.VPCID
    name = "WindowsNodeSG"
    description = "Security group for Windows Node"
tags = {
    Name = "WindowsNodeSG"
}
}


########################
#      Inbound Rules   #
########################
resource "aws_security_group_rule" "ACSAllowSSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.acs-sg.id
}

resource "aws_security_group_rule" "CentosNodeAllowSSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = aws_security_group.acs-sg.id
    security_group_id = aws_security_group.centos-sg.id
}

resource "aws_security_group_rule" "UbuntuNodeAllowSSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = aws_security_group.acs-sg.id
    security_group_id = aws_security_group.ubuntu-sg.id
}
resource "aws_security_group_rule" "WindowsNodeAllowRDP" {
    type = "ingress"
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.windows-sg.id
}
resource "aws_security_group_rule" "NodeAllowWinRM" {
    type = "ingress"
    from_port = 5985
    to_port = 5985
    protocol = "tcp"
    source_security_group_id = aws_security_group.acs-sg.id
    security_group_id = aws_security_group.windows-sg.id
}
########################
#      Inbound Rules   #
########################

#@@@@@@@@@@@@@@@@@@@@@@@

########################
#      Outbound Rules   #
########################

resource "aws_security_group_rule" "ACSOutboundtoAll" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.acs-sg.id
}

resource "aws_security_group_rule" "CentosOutboundtoAll" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.centos-sg.id
}

resource "aws_security_group_rule" "UbuntuOutboundtoAll" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.ubuntu-sg.id
}

resource "aws_security_group_rule" "WindowsOutboundtoAll" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.windows-sg.id
}


########################
#      Outbound Rules  #
########################
