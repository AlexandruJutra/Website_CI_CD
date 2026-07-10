terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# create an S3 bucket
resource "aws_s3_bucket" "first_bucket" {
  bucket = "dev_bucket_terraform_20260710"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}