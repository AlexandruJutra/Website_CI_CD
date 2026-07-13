terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

variable "bucket_prefix" {
  description = "Prefix used in all S3 bucket names (kept secret via GitHub Actions secrets)"
  type        = string
}

resource "random_integer" "bucket_suffix" {
  min = 1000
  max = 9999
}

resource "aws_s3_bucket" "Dev_bucket" {
  bucket        = "dev-bucket-${var.bucket_prefix}-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "Test_bucket" {
  bucket        = "test-bucket-${var.bucket_prefix}-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Test"
  }
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket        = "prod-bucket-${var.bucket_prefix}-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Prod"
  }
}

output "dev_bucket_name" {
  value = aws_s3_bucket.Dev_bucket.bucket
}

output "test_bucket_name" {
  value = aws_s3_bucket.Test_bucket.bucket
}

output "prod_bucket_name" {
  value = aws_s3_bucket.prod_bucket.bucket
}