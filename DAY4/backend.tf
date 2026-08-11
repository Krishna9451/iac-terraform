terraform {
  backend "s3" {
    bucket = "s3-bucket-terraform-11aug"
    region = "ap-south-1"
    key = "Krishna/terraform.tfstate"
  }
}
