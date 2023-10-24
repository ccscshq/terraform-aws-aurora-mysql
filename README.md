# terraform-aws-aurora-mysql

This module provides Aurora MySQL.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_rds_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix for resources. | `string` | n/a | yes |
| <a name="input_rds_allow_major_version_upgrade"></a> [rds\_allow\_major\_version\_upgrade](#input\_rds\_allow\_major\_version\_upgrade) | Whether to major version upgrade of Aurora MySQL. | `bool` | `false` | no |
| <a name="input_rds_availability_zones"></a> [rds\_availability\_zones](#input\_rds\_availability\_zones) | Availability zones of Aurora MySQL. | `set(string)` | n/a | yes |
| <a name="input_rds_backtrack_window"></a> [rds\_backtrack\_window](#input\_rds\_backtrack\_window) | Backtrack window for DB clusters in seconds. Backtracking is only available for DB clusters that were created with the Backtrack feature enabled. | `number` | `0` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | Backup retention period of Aurora MySQL. | `number` | `7` | no |
| <a name="input_rds_cloudwatch_logs_exports"></a> [rds\_cloudwatch\_logs\_exports](#input\_rds\_cloudwatch\_logs\_exports) | Type of logs to output. | `set(string)` | <pre>[<br>  "audit",<br>  "error",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_rds_cloudwatch_logs_retention_in_days"></a> [rds\_cloudwatch\_logs\_retention\_in\_days](#input\_rds\_cloudwatch\_logs\_retention\_in\_days) | Log retention period in days. | `number` | `30` | no |
| <a name="input_rds_cluster_parameters"></a> [rds\_cluster\_parameters](#input\_rds\_cluster\_parameters) | Parameters of RDS cluster. | <pre>map(object({<br>    value        = string<br>    apply_method = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | Database name of Aurora MySQL. | `string` | `null` | no |
| <a name="input_rds_db_parameters"></a> [rds\_db\_parameters](#input\_rds\_db\_parameters) | Parameters of db instances. This parameters override cluster parameters. | <pre>map(object({<br>    value        = string<br>    apply_method = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | Engine version of Aurora MySQL. | `string` | n/a | yes |
| <a name="input_rds_instance_count"></a> [rds\_instance\_count](#input\_rds\_instance\_count) | The number of db instances. | `number` | n/a | yes |
| <a name="input_rds_instance_type"></a> [rds\_instance\_type](#input\_rds\_instance\_type) | Instance class type of DB instances. | `string` | n/a | yes |
| <a name="input_rds_kms_key_arn"></a> [rds\_kms\_key\_arn](#input\_rds\_kms\_key\_arn) | Arn of kms key to encrypt RDS storage. | `string` | `null` | no |
| <a name="input_rds_master_username"></a> [rds\_master\_username](#input\_rds\_master\_username) | Username of Aurora MySQL. | `string` | `null` | no |
| <a name="input_rds_monitoring_interval"></a> [rds\_monitoring\_interval](#input\_rds\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `15` | no |
| <a name="input_rds_preferred_backup_window"></a> [rds\_preferred\_backup\_window](#input\_rds\_preferred\_backup\_window) | Backup window of Aurora MySQL. | `string` | `"19:00-19:30"` | no |
| <a name="input_rds_preferred_maintenance_window"></a> [rds\_preferred\_maintenance\_window](#input\_rds\_preferred\_maintenance\_window) | Maintenance window of Aurora MySQL. | `string` | `"Sat:19:30-Sat:20:00"` | no |
| <a name="input_rds_private_subnet_ids"></a> [rds\_private\_subnet\_ids](#input\_rds\_private\_subnet\_ids) | IDs of DB subnets. | `set(string)` | n/a | yes |
| <a name="input_rds_skip_final_snapshot"></a> [rds\_skip\_final\_snapshot](#input\_rds\_skip\_final\_snapshot) | Whether to skip to create final snapshot. | `bool` | `false` | no |
| <a name="input_rds_source_security_group_ids"></a> [rds\_source\_security\_group\_ids](#input\_rds\_source\_security\_group\_ids) | Set of the ID of the source security group, allowing access to Aurora MySQL from the security group specified by this ID. | `set(string)` | n/a | yes |
| <a name="input_rds_storage_encrypted"></a> [rds\_storage\_encrypted](#input\_rds\_storage\_encrypted) | Whether to encrypt RDS storage. | `bool` | `false` | no |
| <a name="input_rds_vpc_id"></a> [rds\_vpc\_id](#input\_rds\_vpc\_id) | ID of VPC. | `string` | n/a | yes |

## Outputs

No outputs.
