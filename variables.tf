###############################################################
# Root: variables.tf
###############################################################

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g. eut, pt, pr)"
  type        = string
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the VPC to deploy RDS into"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy RDS into"
  type        = string
}

###############################################################
# Engine selector
###############################################################

variable "db_engine" {
  description = "Database engine to deploy: 'mysql' or 'postgres'"
  type        = string
  validation {
    condition     = contains(["mysql", "postgres"], var.db_engine)
    error_message = "db_engine must be either 'mysql' or 'postgres'."
  }
}

###############################################################
# Flat per-database variables (one DB per tfvars + workspace)
###############################################################

variable "db_key" {
  description = "Short name/key for this database, used in resource naming (e.g. aem3)"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "Engine version (e.g. 8.4.5 for MySQL, 17.4 for PostgreSQL)"
  type        = string
}

variable "mysql_major_version" {
  description = "Major MySQL version for parameter group family (e.g. 8.4) — only used for MySQL"
  type        = string
  default     = "8.4"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.large"
}

variable "allocated_storage" {
  description = "Initial allocated storage in GiB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage for autoscaling"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage type: gp2, gp3, io1"
  type        = string
  default     = "gp3"
}

variable "kms_key_id" {
  description = "KMS key ARN for storage encryption (null = AWS managed key)"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs (only used if creating a new subnet group)"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of the existing DB subnet group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of existing security group IDs to attach"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the DB port"
  type        = list(string)
  default     = []
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Days to retain automated backups"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Daily backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Weekly maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "deletion_protection" {
  description = "Prevent accidental deletion"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = false
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
  description = "Log types to export to CloudWatch"
  type        = list(string)
  default     = []
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
