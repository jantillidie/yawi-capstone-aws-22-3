terraform {
  # After running terraform apply with local backend
  # uncomment the backend part and rerun terraform init
  # to switch from local to remote backend:

  # backend "s3" {
  #   bucket         = "yawi-tfstate-bucket-aws223"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-locking"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
