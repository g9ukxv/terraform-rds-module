###############################################################
# Root: main.tf
# Supports both MySQL and PostgreSQL RDS instances.
# Engine is selected via db_engine variable in tfvars.
# One tfvars file per environment — run with:
#   terraform apply -var-file ".\workspace\mysql-non-prod\el2-eut-aem3.tfvars"
#   terraform apply -var-file ".\workspace\psql-non-prod\el2-eut-idb2.tfvars"
###############################################################

#terraform {
#  required_version = ">= 1.5.0"

#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 5.0"
#    }
#  }

  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "rds/${terraform.workspace}/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-lock"
  #   encrypt        = true
  # }
#}

#provider "aws" {
#  region = var.aws_region

#  default_tags {
#    tags = {
#      ManagedBy   = "Terraform"
#      Environment = var.environment
#      Project     = var.project_name
#    }
#  }
#}

###############################################################
# Fetch existing VPC
###############################################################

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

###############################################################
# Locals
###############################################################

locals {
  mysql_parameter_group_name = "el2-mysql-8-4"
  psql_parameter_group_name  = "el2-psql-17"
}

###############################################################
# MySQL RDS instance (used when db_engine = "mysql")
###############################################################

module "mysql_database" {
  source = "./modules/rds_mysql"
  count  = var.db_engine == "mysql" ? 1 : 0

  # Identity & Network
  identifier             = "${var.project_name}-${var.environment}-${var.db_key}"
  vpc_id                 = data.aws_vpc.main.id
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  # Engine
  engine_version      = var.engine_version
  mysql_major_version = var.mysql_major_version
  instance_class      = var.instance_class

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id

  # Credentials
  db_name  = var.db_name
  username = var.username
  password = var.password

  # HA & Backup
  multi_az                   = var.multi_az
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.backup_window
  maintenance_window         = var.maintenance_window
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = var.skip_final_snapshot
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # Monitoring
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports

  # Parameters
  parameter_group_name = local.mysql_parameter_group_name

  tags = {
    Database    = var.db_key
    Environment = var.environment
  }
}

###############################################################
# PostgreSQL RDS instance (used when db_engine = "postgres")
###############################################################

module "psql_database" {
  source = "./modules/rds_psql"
  count  = var.db_engine == "postgres" ? 1 : 0

  # Identity & Network
  identifier             = "${var.project_name}-${var.environment}-${var.db_key}"
  vpc_id                 = data.aws_vpc.main.id
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  # Engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id

  # Credentials
  db_name  = var.db_name
  username = var.username
  password = var.password

  # HA & Backup
  multi_az                   = var.multi_az
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.backup_window
  maintenance_window         = var.maintenance_window
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = var.skip_final_snapshot
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # Monitoring
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports

  # Parameters
  parameter_group_name = local.psql_parameter_group_name

  tags = {
    Database    = var.db_key
    Environment = var.environment
  }
}
