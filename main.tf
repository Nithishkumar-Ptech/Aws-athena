provider "aws" {
  region = var.region
}

module "athena" {
  source          = "./module/"
  bucket_name     = var.bucket_name
  database_name   = var.database_name
  table_name      = var.table_name
  workgroup_name  = var.workgroup_name
  log_group_name  = var.log_group_name
  query_result_location = var.query_result_location
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
}
