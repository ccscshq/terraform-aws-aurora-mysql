module "network" {
  source = "git@github.com:ccscshq/terraform-aws-network.git?ref=v0.2.0"

  prefix                 = local.prefix
  ipv4_cidr              = local.ipv4_cidr
  ipv4_cidr_newbits      = local.ipv4_cidr_newbits
  subnets_number         = local.subnets_number
  create_private_subnets = true
}

module "bastion" {
  source = "git@github.com:ccscshq/terraform-aws-bastion.git?ref=v0.1.1"

  prefix        = local.prefix
  ec2_vpc_id    = module.network.vpc_id
  ec2_subnet_id = module.network.private_subnet_ids[0]
}

module "aurora_mysql" {
  source = "../.."

  prefix                           = local.prefix
  rds_engine_version               = "8.0.mysql_aurora.3.04.0"
  rds_availability_zones           = toset(module.network.private_subnet_azs)
  rds_db_name                      = "dbname"
  rds_instance_count               = 2
  rds_master_username              = "master"
  rds_cloudwatch_logs_exports      = ["audit", "error", "slowquery"]
  rds_skip_final_snapshot          = true
  rds_preferred_backup_window      = "19:00-19:30"
  rds_preferred_maintenance_window = "Sat:19:30-Sat:20:00"
  rds_allow_major_version_upgrade  = false
  rds_backup_retention_period      = 7
  rds_backtrack_window             = 0
  rds_storage_encrypted            = true
  rds_kms_key_arn                  = aws_kms_key.this.arn

  rds_instance_type       = "db.t3.medium"
  rds_monitoring_interval = 15

  rds_cluster_parameters = {
    character_set_server = {
      value = "utf8mb4"
    }
    character_set_client = {
      value = "utf8mb4"
    }
    collation_server = {
      value = "utf8mb4_bin"
    }
    general_log = {
      value = 1
    }
    slow_query_log = {
      value = 1
    }
    long_query_time = {
      value = 1
    }
  }
  rds_db_parameters = {}

  rds_private_subnet_ids = module.network.private_subnet_ids

  rds_vpc_id                   = module.network.vpc_id
  rds_source_security_group_id = module.bastion.security_group_id

  rds_cloudwatch_logs_retention_in_days = 30
}

resource "aws_kms_key" "this" {
  description             = "KMS Key for Aurora MySQL"
  deletion_window_in_days = 7
}

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:*"
        Resource = "*"
      },
    ]
  })
}
