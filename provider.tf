provider "aws" {
   region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-formac-state-file"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-formac-state-lock"
 }
}


provider "template" {
  #version = "~> 0.1"
}
