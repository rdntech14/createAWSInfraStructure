provider "aws" {
  region = "${var.AWS_REGION}"
}

#Creating VPC
# Note : Creating vpc will automatically creates Main Route Table & NACL for VPC
#( but we will not use those, will create new later)
resource "aws_vpc" "VPC_TRF" {
  cidr_block           = "${var.CIDR_VPC}"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "twp_VPC"
  }
}

# Creating Gateway and Associating  to VPC
resource "aws_internet_gateway" "GW_TRF" {
  vpc_id = "${aws_vpc.VPC_TRF.id}"

  tags {
    Name = "twp_gw"
  }
}

# Create Route Table with CIDR Block with Internet Gateway
resource "aws_route_table" "RT_TRF" {
  vpc_id = "${aws_vpc.VPC_TRF.id}"

  tags {
    Name = "twp_rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.GW_TRF.id}"
  }
}

#Create NACL and Allow
resource "aws_network_acl" "NACL_TRF" {
  vpc_id = "${aws_vpc.VPC_TRF.id}"

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "twf_nacl"
  }
}

# Create Subnet and enable Public IP
resource "aws_subnet" "SUBNET_TRF" {
  vpc_id                  = "${aws_vpc.VPC_TRF.id}"
  cidr_block              = "${var.CIDR_SUBNET}"
  map_public_ip_on_launch = "${var.MAP_PUBLIC_IP_ON_LAUNCH}"

  tags {
    Name = "twp_Subnet"
  }
}

# Subnet Assoication with Route Table ( no need at NACL level)
resource "aws_route_table_association" "RT_SUBNET_ASSOCIATION_TRF" {
  subnet_id      = "${aws_subnet.SUBNET_TRF.id}"
  route_table_id = "${aws_route_table.RT_TRF.id}"
}

### Create Subnet
module "createSG_Name" {
  source             = "../createSG"
  AWS_REGION_NAME_SG = "${var.AWS_REGION}"
  VPC_ID_SG          = "${aws_vpc.VPC_TRF.id}"
  TAGS_NAME          = "twp_sg"
}
