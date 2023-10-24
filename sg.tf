resource "aws_security_group" "this" {
  name        = "${var.prefix}-aurora-mysql-sg"
  description = "aurora mysql sg"
  vpc_id      = var.rds_vpc_id

  tags = {
    Name = "${var.prefix}-aurora-mysql-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = var.rds_source_security_group_ids

  security_group_id        = aws_security_group.this.id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
