# Data sources
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}

# Locals (if needed)
locals {
  ami_id             = data.aws_ami.amazon_linux_2023.id
  private_subnet_ids = data.aws_subnets.private_subnets.ids
}

resource "aws_instance" "wordpress" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  subnet_id              = local.private_subnet_ids[0]
  vpc_security_group_ids = [var.web_sg_id]

  tags = {
    Name = "wordpress-instance"
  }
}
