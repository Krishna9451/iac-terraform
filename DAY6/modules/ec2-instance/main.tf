provider "aws" {
  region = "ap-south-1"
}
variable "ec2_instance" {
  description = "This is the aws instance type"
}
variable "ami_id" {
  description = "This is the ami id "
}


resource "aws_instance" "ec2-instance"{
    ami = var.ami_id
    instance_type = var.ec2_instance
    subnet_id = "subnet-09d2d77ed032c455c"
    
    }