terraform {
  required_providers {
    namecheap = {
      source  = "namecheap/namecheap"
      version = ">= 2.0.0"
    }
  }
}

provider "namecheap" {
  user_name   = var.namecheap_api_username
  api_user    = var.namecheap_api_username
  api_key     = var.namecheap_api_key
  use_sandbox = false
}

resource "namecheap_domain_records" "whoogle_dns" {
  domain = var.domain_name
  mode   = "OVERWRITE"

  nameservers = [
    aws_route53_zone.whoogle_dns.name_servers[0],
    aws_route53_zone.whoogle_dns.name_servers[1],
    aws_route53_zone.whoogle_dns.name_servers[2],
    aws_route53_zone.whoogle_dns.name_servers[3],
  ]
}
