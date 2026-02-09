variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "Name of the project (used for resource naming and tagging)"
  type        = string
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 access"
  type        = string
  default     = "vockey"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
