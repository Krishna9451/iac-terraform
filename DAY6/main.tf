provider "aws" {
  region = "ap-south-1"
}

variable "ec2_instance" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t3.micro"
    "stage"="t3.small"
    "prod"="c7i-flex.large"
  }
}
variable "ami_id" {
  description = "value"
}

module "module_ec2" {
  source       = "./modules/ec2-instance"
  ami_id       = var.ami_id
  ec2_instance = lookup(var.ec2_instance,terraform.workspace,"t3.micro")
}

