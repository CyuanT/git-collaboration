data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_security_group" "vpc_sg_data" {
  filter {
    name   = "group-name"
    values = ["luqman-sg-allow-http-https-ssh-from-anywhere-tf-module"]
  }
}

data "aws_ami" "aws_ami_data" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  ami                    = data.aws_ami.aws_ami_data.id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [data.aws_security_group.vpc_sg_data.id]
  subnet_id              = data.aws_subnet.public.id
  user_data              = file("init.sh")
  tags = {
    Terraform = "true"
  }
}

