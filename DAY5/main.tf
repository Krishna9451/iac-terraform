provider "aws" {
  region = "ap-south-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "name_key" {
  key_name   = "my-terraform-key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))

}
resource "aws_vpc" "name_vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "name_subnet_1" {
  vpc_id                  = aws_vpc.name_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "name_igw" {
  vpc_id = aws_vpc.name_vpc.id
}

resource "aws_route_table" "name_rt" {
  vpc_id = aws_vpc.name_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name_igw.id
  }
}

resource "aws_route_table_association" "name_rta" {
  subnet_id      = aws_subnet.name_subnet_1.id
  route_table_id = aws_route_table.name_rt.id
}

resource "aws_security_group" "name_sg" {
  name   = "terr-sg"
  vpc_id = aws_vpc.name_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_instance" "name_instance" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.name_key.key_name
  vpc_security_group_ids = [aws_security_group.name_sg.id]
  subnet_id              = aws_subnet.name_subnet_1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(pathexpand("~/.ssh/id_rsa"))
    host        = self.public_ip

  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello ! Remote exec of the app.py is running '",
      "sudo apt update -y",
      "sudo apt-get install -y python3-flask",

      "sudo python3 /home/ubuntu/app.py &",
    ]
  }


}



