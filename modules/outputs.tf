###############################################################
# Root: outputs.tf
###############################################################

output "rds_endpoint" {
  description = "Connection endpoint for the RDS instance"
  value = var.db_engine == "mysql" ? (
    length(module.mysql_database) > 0 ? module.mysql_database[0].db_instance_endpoint : null
  ) : (
    length(module.psql_database) > 0 ? module.psql_database[0].db_instance_endpoint : null
  )
}

output "rds_address" {
  description = "Hostname of the RDS instance"
  value = var.db_engine == "mysql" ? (
    length(module.mysql_database) > 0 ? module.mysql_database[0].db_instance_address : null
  ) : (
    length(module.psql_database) > 0 ? module.psql_database[0].db_instance_address : null
  )
}

output "rds_arn" {
  description = "ARN of the RDS instance"
  value = var.db_engine == "mysql" ? (
    length(module.mysql_database) > 0 ? module.mysql_database[0].db_instance_arn : null
  ) : (
    length(module.psql_database) > 0 ? module.psql_database[0].db_instance_arn : null
  )
}
