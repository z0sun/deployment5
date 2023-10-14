provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}
############### VPC ######################
resource "aws_vpc" "deploy5vpc" {
  cidr_block         = "10.0.0.0/16"
  instance_tenancy   = "default"
  enable_dns_support = true
  tags = {
    Name = "deploy5vpc"
  }
}

# ################ INTERNET GATEWAY #############

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.deploy5vpc.id

  tags = {
    Name = "gw"
  }
}

# # ############ ROUTE TABLE ###############
# resource "aws_route_table" "route5" {
#   vpc_id = aws_vpc.deploy5vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }
# }

resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.deploy5vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}


############## SUBNETS #################
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.deploy5vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.deploy5vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet2"
  }
}
################ SECURITY GROUP ##################
resource "aws_security_group" "allow_selected_ports" {
  name        = "allow_selected_ports"
  description = "Allow inbound traffic on ports 8000, 8080, and 22"
  vpc_id      = aws_vpc.deploy5vpc.id
  # Ingress rule for port 8000
  ingress {
    description = "Allow port 8000"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Ingress rule for port 8080
  ingress {
    description = "Allow port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Ingress rule for port 22
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Default egress rule to allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "allow_selected_ports"
    Terraform = "true"
  }
}
############# INSTANCES ##################

data "template_file" "jenkins_file" {
  template = file("${path.module}/jenkins.sh")
}

data "template_file" "python_install" {
  template = file("${path.module}/pythoninstall.sh")
}

resource "aws_instance" "jenkins" {
  ami                         = var.ami
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.allow_selected_ports.id]
  subnet_id                   = aws_subnet.subnet1.id
  user_data                   = <<-EOF
                                #!/bin/bash
                                ${data.template_file.jenkins_file.rendered}
                                ${data.template_file.python_install.rendered}
                                EOF
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "app_python" {
  ami                         = var.ami
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.allow_selected_ports.id]
  subnet_id                   = aws_subnet.subnet2.id
  user_data                   = data.template_file.python_install.rendered
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "App_python"
  }
}


