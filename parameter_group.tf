###############################################################
# Shared parameter groups — managed independently per engine.
# Import commands:
#   terraform import -var-file="..." aws_db_parameter_group.mysql el2-mysql-8-4
#   terraform import -var-file="..." aws_db_parameter_group.psql  el2-psql-17
###############################################################

resource "aws_db_parameter_group" "mysql" {
  name        = "el2-mysql-8-4"
  family      = "mysql8.4"
  description = "This parameter group is used in 8.4.x version"

  skip_destroy = true   # keeps the group in AWS even on terraform destroy

  parameter {
    apply_method = "immediate"
    name         = "binlog_format"
    value        = "ROW"
  }
  parameter {
    apply_method = "immediate"
    name         = "table_open_cache"
    value        = "64"
  }
  parameter {
    apply_method = "immediate"
    name         = "thread_cache_size"
    value        = "16"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "innodb_doublewrite_pages"
    value        = "32"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "skip_show_database"
    value        = "0"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_db_parameter_group" "psql" {
  name        = "el2-psql-17"
  family      = "postgres17"
  description = "This Parameter group is used for Postgres 17.x Versions"

  skip_destroy = true   # keeps the group in AWS even on terraform destroy

  parameter {
    apply_method = "immediate"
    name         = "auto_explain.log_min_duration"
    value        = "5000"
  }
  parameter {
    apply_method = "immediate"
    name         = "autovacuum_analyze_scale_factor"
    value        = "0.2"
  }
  parameter {
    apply_method = "immediate"
    name         = "autovacuum_analyze_threshold"
    value        = "300"
  }
  parameter {
    apply_method = "immediate"
    name         = "checkpoint_timeout"
    value        = "300"
  }
  parameter {
    apply_method = "immediate"
    name         = "commit_delay"
    value        = "4000"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_connections"
    value        = "1"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_disconnections"
    value        = "1"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_hostname"
    value        = "0"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_min_duration_statement"
    value        = "1000"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_min_error_statement"
    value        = "error"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_rotation_age"
    value        = "1440"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_rotation_size"
    value        = "1048576"
  }
  parameter {
    apply_method = "immediate"
    name         = "log_statement"
    value        = "ddl"
  }
  parameter {
    apply_method = "immediate"
    name         = "max_wal_size"
    value        = "30720"
  }

  lifecycle {
    prevent_destroy = false
  }
}
