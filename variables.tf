variable "prefix" {
  description = "Name prefix for resources."
  type        = string
}

# rds cluster
variable "rds_engine_version" {
  description = "Engine version of Aurora MySQL."
  type        = string
}
variable "rds_availability_zones" {
  description = "Availability zones of Aurora MySQL."
  type        = set(string)
}
variable "rds_db_name" {
  description = "Database name of Aurora MySQL."
  type        = string
  default     = null
}
variable "rds_instance_count" {
  description = "The number of db instances."
  type        = number
}
variable "rds_master_username" {
  description = "Username of Aurora MySQL."
  type        = string
  default     = null
}
variable "rds_cloudwatch_logs_exports" {
  description = "Type of logs to output."
  type        = set(string)
  default     = ["audit", "error", "slowquery"]
}
variable "rds_skip_final_snapshot" {
  description = "Whether to skip to create final snapshot."
  type        = bool
  default     = false
}
variable "rds_preferred_backup_window" {
  description = "Backup window of Aurora MySQL."
  type        = string
  default     = "19:00-19:30"
}
variable "rds_preferred_maintenance_window" {
  description = "Maintenance window of Aurora MySQL."
  type        = string
  default     = "Sat:19:30-Sat:20:00"
}
variable "rds_allow_major_version_upgrade" {
  description = "Whether to major version upgrade of Aurora MySQL."
  type        = bool
  default     = false
}
variable "rds_backup_retention_period" {
  description = "Backup retention period of Aurora MySQL."
  type        = number
  default     = 7
}
variable "rds_backtrack_window" {
  description = "Backtrack window for DB clusters in seconds. Backtracking is only available for DB clusters that were created with the Backtrack feature enabled."
  type        = number
  default     = 0

  validation {
    condition     = var.rds_backtrack_window >= 0 && var.rds_backtrack_window <= 259200
    error_message = "Aurora MySQL Backtrack window must be set between 0 and 259200 seconds."
  }
}
variable "rds_storage_encrypted" {
  description = "Whether to encrypt RDS storage."
  type        = bool
  default     = false
}
variable "rds_kms_key_arn" {
  description = "Arn of kms key to encrypt RDS storage."
  type        = string
  default     = null
}

# rds instance
variable "rds_instance_type" {
  description = "Instance class type of DB instances."
  type        = string
}
variable "rds_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 15
}

# rds pg
variable "rds_cluster_parameters" {
  description = "Parameters of RDS cluster."
  type = map(object({
    value        = string
    apply_method = optional(string)
  }))

  default = {}
}
variable "rds_db_parameters" {
  description = "Parameters of db instances. This parameters override cluster parameters."
  type = map(object({
    value        = string
    apply_method = optional(string)
  }))

  default = {}
}

# db subnet
variable "rds_private_subnet_ids" {
  description = "IDs of DB subnets."
  type        = set(string)
}

# sg
variable "rds_vpc_id" {
  description = "ID of VPC."
  type        = string
}
variable "rds_source_security_group_id" {
  description = "ID of the source security group, allowing access to Aurora MySQL from the security group specified by this ID."
  type        = string
}

# cw
variable "rds_cloudwatch_logs_retention_in_days" {
  description = "Log retention period in days."
  type        = number
  default     = 30
}
