provider "aws" {
  region = "ap-south-1"
}
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-01a00762f46d584a1"
  instance_value = "t3.micro"
  subnet_value = "subnet-0fc15f9550f62d581"

}