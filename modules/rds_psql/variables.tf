###############################################################
# Module: modules/rds_psql/variables.tf
###############################################################

variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be created"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of an existing DB subnet group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of existing security group IDs to attach"
  type        = list(string)
}

variable "engine_version" {
  description = "PostgreSQL engine version (e.g. 17.4)"
  type        = string
  default     = "17.4"
}

variable "instance_class" {
  description = "RDS instance type (e.g. db.t3.medium, db.r7g.large)"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Initial allocated storage in GiB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage for autoscaling (0 = disabled)"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type: gp2, gp3, io1"
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Whether to encrypt the storage at rest"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ARN for storage encryption (null = AWS managed key)"
  type        = string
  default     = null
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether the instance should be publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups (0 = disabled)"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Daily time range for automated backups (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Weekly time range for maintenance (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "apply_immediately" {
  description = "Apply changes immediately instead of next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Automatically apply minor engine upgrades"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Prevent accidental deletion of the instance"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy (set false for production)"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds (0 = disabled)"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "Existing IAM role ARN for enhanced monitoring. If null and monitoring_interval > 0, a new role is created."
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention in days (7 or 731)"
  type        = number
  default     = 7
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Log types to export to CloudWatch. For PostgreSQL: postgresql, upgrade"
  type        = list(string)
  default     = ["postgresql", "upgrade"]
}

variable "parameter_group_name" {
  description = "Name of an existing DB parameter group to use"
  type        = string
  default     = null
}

variable "db_parameters" {
  description = "List of DB parameters to apply"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "immediate")
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
