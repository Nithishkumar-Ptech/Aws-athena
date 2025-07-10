resource "aws_s3_bucket" "athena_results" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.athena_results.id
  acl    = "private"
}

resource "aws_athena_database" "this" {
  name   = var.database_name
  bucket = aws_s3_bucket.athena_results.bucket
}

resource "aws_athena_workgroup" "this" {
  name = var.workgroup_name

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_results.bucket}/results/"
    }
  }
}

resource "aws_glue_catalog_table" "this" {
  name          = var.table_name
  database_name = aws_athena_database.this.name

  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.athena_results.bucket}/data/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    serde_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "field.delim" = ","
      }
    }

    columns = [
      {
        name = "id"
        type = "string"
      },
      {
        name = "value"
        type = "string"
      }
    ]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = 7
}
