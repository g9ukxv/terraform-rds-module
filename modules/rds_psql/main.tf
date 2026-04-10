###############################################################
# Module: modules/rds_psql/main.tf
# Reusable RDS PostgreSQL instance module
###############################################################

resource "aws_db_instance" "this" {
  identifier = var.identifier

  # Engine
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = var.kms_key_id

  # Credentials
  db_name  = var.db_name
  username = var.username
  password = var.password

  # Network
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible
  port                   = 5432

  # Parameter Group
  parameter_group_name = var.parameter_group_name

  # Backup & Maintenance
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.backup_window
  maintenance_window         = var.maintenance_window
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = var.skip_final_snapshot
  final_snapshot_identifier  = var.skip_final_snapshot ? null : "${var.identifier}-final-snapshot"

  # Monitoring
  monitoring_interval           = var.monitoring_interval
  monitoring_role_arn           = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
  performance_insights_enabled  = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # Multi-AZ
  multi_az = var.multi_az

  tags = merge(var.tags, {
    Name = var.identifier
  })
}

# IAM Role for Enhanced Monitoring (created only when monitoring_interval > 0 and no external role provided)
resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = var.monitoring_interval > 0 && var.monitoring_role_arn == null ? 1 : 0

  name = "${var.identifier}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "monitoring.rds.amazonaws.com" }
    }]
  })

 # managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]

  tags = var.tags
}
