provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.prefix}-${var.environment}-${var.bucket_name}"

  tags = {
    Name        = "${var.prefix}-${var.environment}-${var.bucket_name}"
    Environment = var.environment
    Terraform   = "true"
    Component   = var.component_name
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}