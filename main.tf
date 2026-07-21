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

resource "random_integer" "bucket_suffix" {
  min = 1000
  max = 9999
}

resource "aws_s3_bucket" "Dev_bucket" {
  bucket        = "dev-bucket-terraform-bakery2026-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "Test_bucket" {
  bucket        = "test-bucket-terraform-bakery2026-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Test"
  }
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket        = "prod-bucket-terraform-bakery2026-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Prod"
  }
}
