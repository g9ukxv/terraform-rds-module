###############################################################
# Parameter Groups — one created per engine + environment tier
#
# Conditions:
#   mysql-non-prod  → db_engine=mysql    + environment_tier=non-prod
#   mysql-prod      → db_engine=mysql    + environment_tier=prod
#   psql-non-prod   → db_engine=postgres + environment_tier=non-prod
#   psql-prod       → db_engine=postgres + environment_tier=prod
#
# Import commands:
#   terraform import -var-file="..." "aws_db_parameter_group.mysql_non_prod[0]" el2-mysql-8-4-non-prod
#   terraform import -var-file="..." "aws_db_parameter_group.mysql_prod[0]"     el2-mysql-8-4-prod
#   terraform import -var-file="..." "aws_db_parameter_group.psql_non_prod[0]"  el2-psql-17-non-prod
#   terraform import -var-file="..." "aws_db_parameter_group.psql_prod[0]"      el2-psql-17-prod
###############################################################

# ── MySQL Non-Prod ────────────────────────────────────────────
resource "aws_db_parameter_group" "mysql_non_prod" {
  count = var.db_engine == "mysql" && var.environment_tier == "non-prod" ? 1 : 0

  name        = "el2-mysql-8-4-non-prod"
  family      = "mysql8.4"
  description = "MySQL 8.4 parameter group for non-prod environments"
  skip_destroy = true

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

# ── MySQL Prod ────────────────────────────────────────────────
resource "aws_db_parameter_group" "mysql_prod" {
  count = var.db_engine == "mysql" && var.environment_tier == "prod" ? 1 : 0

  name        = "el2-mysql-8-4-prod"
  family      = "mysql8.4"
  description = "MySQL 8.4 parameter group for prod environment"
  skip_destroy = true

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

# ── PostgreSQL Non-Prod ───────────────────────────────────────
resource "aws_db_parameter_group" "elis-postgres-pg-15-no-md5" {
  count = var.db_engine == "postgres" && var.environment_tier == "non-prod" ? 1 : 0

  name        = "elis-postgres-pg-15-no-md5"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for non-prod environments"
  skip_destroy = true

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

resource "aws_db_parameter_group" "elis-postgres-pg-15-lrg-wal-keep" {
  count = var.db_engine == "postgres" && var.environment_tier == "non-prod" ? 1 : 0

  name        = "elis-postgres-pg-15-lrg-wal-keep"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for non-prod environments"
  skip_destroy = true

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

resource "aws_db_parameter_group" "elis-postgres-pg-15" {
  count = var.db_engine == "postgres" && var.environment_tier == "non-prod" ? 1 : 0

  name        = "elis-postgres-pg-15"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for non-prod environments"
  skip_destroy = true

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

# ── PostgreSQL Prod ───────────────────────────────────────
## elis-default-postgres-pg-15
# Used by: el2-dm-idb2, el2-dm-ms-consolidated-1, el2-dm-ms-consolidated-3,
#          el2-dm-ms-draft-case, el2-dm-ms-tecs-check, el2-pe-idb2,
#          el2-pe-ms-consolidated-3, el2-pe-tecs6, el2-pp-idb2, el2-pp-idb4,
#          el2-pr-idb2, el2-pr-idb4, el2-pr-its6, el2-pr-mic5,
#          elis-ms-db-dm, elis-ms-db-pp
resource "aws_db_parameter_group" "elis-default-postgres-pg-15" {
  count = var.db_engine == "postgres" && var.environment_tier == "prod" && contains([
    "el2-dm-idb2", "el2-dm-ms-consolidated-1", "el2-dm-ms-consolidated-3",
    "el2-dm-ms-draft-case", "el2-dm-ms-tecs-check", "el2-pe-idb2",
    "el2-pe-ms-consolidated-3", "el2-pe-tecs6", "el2-pp-idb2", "el2-pp-idb4",
    "el2-pr-idb2", "el2-pr-idb4", "el2-pr-its6", "el2-pr-mic5",
    "elis-ms-db-dm", "elis-ms-db-pp"
  ], var.identifier) ? 1 : 0

  name        = "elis-default-postgres-pg-15"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for prod environment"
  skip_destroy = true

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

## elis-postgres15-small
# Used by: el2-pp-mic5, elis-ms-db-pe
resource "aws_db_parameter_group" "elis-postgres15-small" {
  count = var.db_engine == "postgres" && var.environment_tier == "prod" && contains([
    "el2-pp-mic5", "elis-ms-db-pe"
  ], var.identifier) ? 1 : 0

  name        = "elis-postgres15-small"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for prod environment"
  skip_destroy = true

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

## elis-postgres-15-for-replication
# Used by: el2-pr-tecs6, el2-pr-ms-consolidated-1, el2-pr-ms-consolidated-2,
#          el2-pr-ms-consolidated-3, el2-pr-ms-consolidated-4, el2-pr-ms-consolidated-5
resource "aws_db_parameter_group" "elis-postgres-15-for-replication" {
  count = var.db_engine == "postgres" && var.environment_tier == "prod" && contains([
    "el2-pr-tecs6", "el2-pr-ms-consolidated-1", "el2-pr-ms-consolidated-2",
    "el2-pr-ms-consolidated-3", "el2-pr-ms-consolidated-4", "el2-pr-ms-consolidated-5"
  ], var.identifier) ? 1 : 0

  name        = "elis-postgres-15-for-replication"
  family      = "postgres17"
  description = "PostgreSQL 17 parameter group for prod environment"
  skip_destroy = true

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
