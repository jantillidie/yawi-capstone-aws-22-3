#====================================================
# Route 53
#====================================================
resource "aws_route53_zone" "whoogle_dns" {
  name = var.domain_name
}

# resource "namecheap_domain_records" "whoogle_dns" {
#   domain = var.domain_name
#   mode   = "OVERWRITE"

#   nameservers = [
#     aws_route53_zone.whoogle_dns.name_servers[0],
#     aws_route53_zone.whoogle_dns.name_servers[1],
#     aws_route53_zone.whoogle_dns.name_servers[2],
#     aws_route53_zone.whoogle_dns.name_servers[3],
#   ]
# }

# resource "inwx_domain" "whoogle_dns" {
#   name = var.domain_name
#   nameservers = [
#     aws_route53_zone.whoogle_dns.name_servers[0],
#     aws_route53_zone.whoogle_dns.name_servers[1],
#     aws_route53_zone.whoogle_dns.name_servers[2],
#     aws_route53_zone.whoogle_dns.name_servers[3],
#   ]
#   period = "1Y"
#   renewal_mode = "AUTORENEW"
#   transfer_lock = true
#   contacts {
#     registrant = 2147483647 // id of contact
#     admin  = 2147483647 // id of contact
#     tech  = 2147483647 // id of contact
#     billing  = 2147483647 // id of contact
#   }
#   extra_data = {
#     // Enable e.g. whois protection
#     "WHOIS-PROTECTION": "1" // 1 == bool true
#   }
# }

#====================================================
# ACM - AWS Certificate Manager
#====================================================
resource "aws_acm_certificate" "whoogle_site" {
  domain_name       = var.cert_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "whoogle_site_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.whoogle_site.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.whoogle_dns.zone_id
}

resource "aws_acm_certificate_validation" "whoogle_site" {
  certificate_arn         = aws_acm_certificate.whoogle_site.arn
  validation_record_fqdns = [for record in aws_route53_record.whoogle_site_certificate_validation : record.fqdn]
}

resource "aws_route53_record" "whoogle_site_a_record" {
  zone_id = aws_route53_zone.whoogle_dns.zone_id
  name    = var.cert_domain
  type    = "A"

  alias {
    name                   = aws_lb.whoogle_alb.dns_name
    zone_id                = aws_lb.whoogle_alb.zone_id
    evaluate_target_health = true
  }
}
