provider "aws" {
    region = "ap-south-1"
}
resource "aws_instance" "Krishna" {
  instance_type = "t3.micro"
  ami = "ami-01a00762f46d584a1"
  subnet_id = "subnet-0a9f8e5e7d4c106da"
  tags = {
    Name ="Krishna_instance"
  }
}

resource "aws_s3_bucket" "Krishna_bucket" {
  bucket = "s3-bucket-terraform-11aug"

}