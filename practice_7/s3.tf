resource "aws_s3_bucket" "cerberus_bucket" {
  bucket = local.s3-sufix # Locals is useful to assign needed unique names to S3 buckets
}