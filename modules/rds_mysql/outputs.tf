###############################################################
# Module: modules/rds_mysql/outputs.tf
###############################################################

output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS instance ARN"
  value       = aws_db_instance.this.arn
}

output "db_instance_endpoint" {
  description = "Connection endpoint (host:port)"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_address" {
  description = "Hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "Port of the RDS instance"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Name of the database"
  value       = aws_db_instance.this.db_name
}

#output "db_subnet_group_name" {
#  description = "DB subnet group name"
#  value       = aws_db_subnet_group.this.name
#}

#output "security_group_id" {
#  description = "Security group ID attached to the RDS instance"
#  value       = aws_security_group.rds.id
#}
