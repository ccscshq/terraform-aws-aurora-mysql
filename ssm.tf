resource "aws_ssm_parameter" "this" {
  name  = "/${var.prefix}/rds_aurora_mysql/master_password"
  type  = "SecureString"
  value = random_password.this.result
}
