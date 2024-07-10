terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = var.PORTFOLIO_ACCESS_KEY
  secret_key = var.PORTFOLIO_SECRET_KEY
}

# Generate PEM file
resource "tls_private_key" "rsa_2048" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

variable "key_name" {}

# Key pair for AWS
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_2048.public_key_openssh
}

# Create local private key
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_2048.private_key_pem
  filename = var.key_name
}

# Creating EC2 instance
resource "aws_instance" "myportfolio" {
  ami           = "ami-0862be96e41dcbf74"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name

  tags = {
    Name = "myportfolio"
  }
}

