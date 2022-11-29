terraform {
  # After running terraform apply with local backend
  # uncomment the backend part and rerun terraform init
  # to switch from local to remote backend:

  backend "s3" {
    bucket = "yawi-tfstate-bucket-aws223-758393"
    key    = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
