provider "aws" {
  region = "eu-central-1"
}

# terraform {
#   backend "s3" {
#     bucket         = "homework-tf-states"
#     encrypt        = true
#     key            = "main-infra/terraform.tfstate"
#     region         = "eu-central-1"
#     dynamodb_table = "homework-tf-locks"
#   }
# }

locals {
  web_instance_type_map = {
    stage = "t2.micro"
    prod  = "t2.micro"
  }
}

locals {
  web_instance_count_map = {
    stage = 1
    prod  = 2
  }
}

locals {
  instances = {
    "stage" = "1"
    "prod" = "2"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# resource "aws_vpc" "vpc-test" {
#   cidr_block = "172.16.0.0/16"

#   tags = {
#     Name = "vpc-test"
#   }
# }

# resource "aws_subnet" "subnet-test" {
#   vpc_id     = aws_vpc.vpc-test.id
#   cidr_block = "172.16.10.0/24"

#   tags = {
#     Name = "subnet-test"
#   }
# }

# resource "aws_network_interface" "nic" {
#   subnet_id = aws_subnet.subnet-test.id
#   #private_ips = ["172.16.10.100"]

#   tags = {
#     Name = "primary_nic"
#   }
# }

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = local.web_instance_type_map[terraform.workspace]
#   count         = local.web_instance_count_map[terraform.workspace]

#   lifecycle {
#     create_before_destroy = true
#   }

#   #  network_interface {
#   #    network_interface_id = aws_network_interface.nic.id
#   #    device_index         = 0
#   #  }
#   # tags = {
#   #   Name = "test-vm"
#   # }
# }

resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "main-key"
  

  lifecycle {
    create_before_destroy = true
  }
}

