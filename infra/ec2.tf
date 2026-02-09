data "aws_ami" "al2023_kernel61" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "team_vm" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  key_name = var.key_name

  iam_instance_profile = "LabInstanceProfile"
  monitoring           = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = file("${path.module}/../scripts/bootstrap-nginx.sh")

  tags = {
    Name = "${var.project_name}-vm"
  }
}