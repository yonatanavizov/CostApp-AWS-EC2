variable "aws_key_pair" {
  default = "~/Desktop/aws_keys/yoni-key.pem"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.2"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my_security" {
  name   = "costAppNode_security_group"
  vpc_id = "vpc-0eefaeeaf4f29af7e"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1030
    to_port     = 1030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    name = "cost"
  }
}





resource "aws_instance" "yoni-ec2-instance" {
  ami                    = "ami-05fa00d4c63e32376"
  key_name               = "yoni-key"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_security.id]
  subnet_id              = "subnet-0bc2495a4247815c5"
}


