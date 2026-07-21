variable "bucket_prefix" {
  description = "Prefix used in all S3 bucket names (kept secret via GitHub Actions secrets)"
  type        = string
}

variable "terraform_state_bucket" {
  description = "Name of the S3 bucket used for storing the Terraform state file"
  type        = string
}