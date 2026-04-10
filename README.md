# terraform-rds-module
Terraform Code to implement existing RDS Instance

-- Create Workspace
--
terraform workspace new mysql-eut

terraform workspace new mysql-pt

terraform workspace new mysql-pr

terraform workspace new psql-eut

-- List Workspace
--
terraform workspace list

-- Select Workspace
--
terraform workspace select mysql-eut

terraform workspace select mysql-pt

terraform workspace select mysql-pr

-- Current Workspace you are in
--
terraform workspace show

