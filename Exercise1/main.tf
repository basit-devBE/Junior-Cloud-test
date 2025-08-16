variable "aws_region"{
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "eu-north-1"
}

terraform {
  required_providers {
    aws ={
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.aws_region  
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
    default     = "t3.nano"
}

variable "instance_name" {
    description = "Name of EC2 instance"
    type        = string
    default     = "terraform-demo"
}

resource "aws_security_group" "demo_devops" {
    name = "demo_devops"
    description = "Allow all inbound traffic to the server"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "Demo-resource" {
    ami = "ami-042b4708b1d05f512"
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.demo_devops.id ]
        user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y nginx
                echo "Hello Devops" | sudo tee /var/www/html/index.html
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF
   tags = {
        Name = var.instance_name
    }
  
}


