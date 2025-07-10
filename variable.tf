variable "region" {}
variable "bucket_name" {}
variable "database_name" {}
variable "table_name" {}
variable "workgroup_name" {}
variable "log_group_name" {}
variable "query_result_location" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
