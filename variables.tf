variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "app"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "development", "staging", "prod", "production"], var.environment)
    error_message = "Environment must be one of: dev, development, staging, prod, production."
  }
}

variable "bucket_name" {
  description = "Name of the S3 bucket to create (will be prefixed with environment)"
  type        = string
  default     = "storage"
}

variable "component_name" {
  description = "Name of the component using this bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Map of lifecycle rules to configure"
  type        = map(any)
  default     = {}
}

# outputs.tf
output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.app_bucket.id
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.app_bucket.arn
}

output "bucket_region" {
  description = "Region of the created S3 bucket"
  value       = var.region
}