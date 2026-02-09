variable "partner_vpc_id" {
  type    = string
  default = null
}

variable "partner_region" {
  type    = string
  default = "us-east-1"
}

variable "partner_account_id" {
  type    = string
  default = null
}

variable "partner_vpc_cidr" {
  type    = string
  default = null
}

resource "aws_vpc_peering_connection" "peer" {
  count = (var.partner_vpc_id != null && var.partner_account_id != null) ? 1 : 0

  vpc_id        = aws_vpc.main.id
  peer_owner_id = var.partner_account_id
  peer_vpc_id   = var.partner_vpc_id
  peer_region   = var.partner_region
  auto_accept   = false

  tags = {
    Name = "${var.project_name}-to-partner"
  }
}