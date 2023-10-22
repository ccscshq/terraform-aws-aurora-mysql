resource "aws_rds_cluster" "this" {
  cluster_identifier           = "${var.prefix}-aurora-mysql"
  engine                       = "aurora-mysql"
  engine_version               = var.rds_engine_version
  availability_zones           = var.rds_availability_zones
  database_name                = coalesce(var.rds_db_name, var.prefix)
  master_username              = coalesce(var.rds_master_username, var.prefix)
  master_password              = aws_ssm_parameter.this.value
  backup_retention_period      = var.rds_backup_retention_period
  preferred_backup_window      = var.rds_preferred_backup_window
  preferred_maintenance_window = var.rds_preferred_maintenance_window
  final_snapshot_identifier    = "${var.prefix}-final"
  vpc_security_group_ids = [
    aws_security_group.this.id
  ]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  db_subnet_group_name            = aws_db_subnet_group.this.id
  apply_immediately               = true
  enabled_cloudwatch_logs_exports = var.rds_cloudwatch_logs_exports
  skip_final_snapshot             = var.rds_skip_final_snapshot
  allow_major_version_upgrade     = var.rds_allow_major_version_upgrade
  backtrack_window                = var.rds_backtrack_window
  storage_encrypted               = var.rds_storage_encrypted
  kms_key_id                      = var.rds_kms_key_arn

  lifecycle {
    # https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/rds_cluster#availability_zones
    ignore_changes = [availability_zones]
  }
}

resource "aws_rds_cluster_instance" "this" {
  count = var.rds_instance_count

  engine                  = "aurora-mysql"
  identifier              = "${var.prefix}-aurora-mysql-db-${count.index}"
  cluster_identifier      = aws_rds_cluster.this.id
  instance_class          = var.rds_instance_type
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.this.id
  db_parameter_group_name = aws_db_parameter_group.this.name
  monitoring_role_arn     = aws_iam_role.this.arn
  monitoring_interval     = var.rds_monitoring_interval
  apply_immediately       = true

}

resource "aws_db_subnet_group" "this" {
  name       = "${var.prefix}-aurora-mysql"
  subnet_ids = var.rds_private_subnet_ids
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.prefix}-cluster-pg-aurora80"
  family      = "aurora-mysql8.0"
  description = "custom cluster cluster parameter group for Aurora 8.0"

  dynamic "parameter" {
    for_each = var.rds_cluster_parameters

    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.prefix}-instance-pg-aurora80"
  family      = "aurora-mysql8.0"
  description = "custom instance parameter group for Aurora 8.0"

  dynamic "parameter" {
    for_each = var.rds_db_parameters

    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}
