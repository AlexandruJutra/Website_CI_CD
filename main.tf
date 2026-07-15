terraform {
  # Configure the backend to use an S3 bucket for storing the Terraform state file
  backend "s3" {
    bucket       = "terraform-state-bucket-md-2026"
    key          = "dev/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }

  # set the required providers for the project
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