terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    # namecheap = {
    #   source  = "namecheap/namecheap"
    #   version = ">= 2.0.0"
    # }
    # inwx = {
    #   source  = "inwx/inwx"
    #   version = ">= 1.0.0"
    # }
  }
}

provider "aws" {
  region = "us-east-1"
}

# provider "namecheap" {
#   user_name   = var.namecheap_api_username
#   api_user    = var.namecheap_api_username
#   api_key     = var.namecheap_api_key
#   use_sandbox = false
# }

# provider "inwx" {
#   api_url  = "https://api.ote.domrobot.com/jsonrpc/"
#   username = var.inwx_user
#   password = var.inwx_pw
# }
