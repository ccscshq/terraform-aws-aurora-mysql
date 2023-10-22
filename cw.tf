resource "aws_cloudwatch_log_group" "aurora" {
  name              = "/${var.prefix}/aws/rds/aurora_mysql/${var.rds_db_name}"
  retention_in_days = var.rds_cloudwatch_logs_retention_in_days
}
