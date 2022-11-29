terraform {
  # After running terraform apply with local backend
  # uncomment the backend part and rerun terraform init
  # to switch from local to remote backend:

  backend "s3" {
    bucket = "yawi-tfstate-bucket-aws223"
    key    = "terraform.tfstate"
    region = "us-west-2"
    # dynamodb_table = "terraform-state-locking"
    # encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# resource "aws_instance" "test" {
#   ami           = "ami-08e2d37b6a0129927"
#   instance_type = "t2.micro"
# }

# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = "yawi-tfstate-bucket-aws223-758393"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
#   bucket = aws_s3_bucket.terraform_state.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-state-locking"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
