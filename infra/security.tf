resource "aws_security_group" "ec2_sg" {
  name   = "${var.project_name}-ec2-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

resource "aws_security_group_rule" "allow_http_from_partner" {
  count = var.partner_vpc_cidr != null ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.partner_vpc_cidr]
  description       = "HTTP from partner VPC over peering"
}

resource "aws_security_group_rule" "allow_icmp_from_partner" {
  count = var.partner_vpc_cidr != null ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.ec2_sg.id
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.partner_vpc_cidr]
  description       = "ICMP from partner VPC over peering"
}

