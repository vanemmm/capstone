# who is the provider and where the resources are going
provider "aws" {
  region = "us-east-1"
}



# vpc with a generated unique id
resource "random_id" "vpc" {
  byte_length = 8
}

resource "aws_vpc" "DeployLab_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "DeployLab_VPC-${random_id.vpc.hex}"
  }
}



# subnets - four private and two public
locals {
  public_subnets = {
    public-1 = { cidr = "10.0.1.0/24", az = "us-east-1a" }
    public-4 = { cidr = "10.0.2.0/24", az = "us-east-1b" }
  }

  private_subnets = {
    private-2 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
    private-3 = { cidr = "10.0.5.0/24", az = "us-east-1a" }
    private-5 = { cidr = "10.0.6.0/24", az = "us-east-1b" }
    private-6 = { cidr = "10.0.7.0/24", az = "us-east-1b" }
  }
}

resource "aws_subnet" "public" {
  for_each                = local.public_subnets
  vpc_id                  = aws_vpc.DeployLab_VPC.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private" {
  for_each                = local.private_subnets
  vpc_id                  = aws_vpc.DeployLab_VPC.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name = each.key
  }
}

