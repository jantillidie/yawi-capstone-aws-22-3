terraform {
  required_providers {
    inwx = {
      source  = "inwx/inwx"
      version = ">= 1.0.0"
    }
  }
}

provider "inwx" {
  api_url  = "https://api.ote.domrobot.com/jsonrpc/"
  username = var.inwx_user
  password = var.inwx_pw
}

resource "inwx_domain" "whoogle_dns" {
  name = var.domain_name
  nameservers = [
    aws_route53_zone.whoogle_dns.name_servers[0],
    aws_route53_zone.whoogle_dns.name_servers[1],
    aws_route53_zone.whoogle_dns.name_servers[2],
    aws_route53_zone.whoogle_dns.name_servers[3],
  ]
  period        = "1Y"
  renewal_mode  = "AUTORENEW"
  transfer_lock = true
  contacts {
    registrant = 2147483647 // id of contact
    admin      = 2147483647 // id of contact
    tech       = 2147483647 // id of contact
    billing    = 2147483647 // id of contact
  }
  extra_data = {
    // Enable e.g. whois protection
    "WHOIS-PROTECTION" : "1" // 1 == bool true
  }
}
