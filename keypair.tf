resource "aws_key_pair" "acsKeyPair" {
    key_name = "acsKeyPair"
    public_key = file(var.ACS_PUB_KEY)
}

resource "aws_key_pair" "centosKeyPair" {
    key_name = "centosKeyPair"
    public_key = file(var.CENTOS_PUB_KEY)

}

resource "aws_key_pair" "ubuntuKeyPair" {
    key_name = "ubuntuKeyPair"
    public_key = file(var.UBUNTU_PUB_KEY)
}

resource "aws_key_pair" "windowsKeyPair" {
    key_name = "windowsKeyPair"
    public_key = file(var.WINDOWS_PUB_KEY)
}
