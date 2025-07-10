output "database" {
  value = aws_athena_database.this.name
}

output "table" {
  value = aws_glue_catalog_table.this.name
}

output "workgroup" {
  value = aws_athena_workgroup.this.name
}
