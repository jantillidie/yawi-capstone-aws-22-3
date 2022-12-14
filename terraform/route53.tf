#====================================================
# Route 53
#====================================================
resource "aws_route53_zone" "whoogle_dns" {
  name = var.domain_name
}

#====================================================
# ACM - AWS Certificate Manager
# Uncomment this after setting ns records for domain
#====================================================
# resource "aws_acm_certificate" "whoogle_site" {
#   domain_name       = var.cert_domain
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "whoogle_site_certificate_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.whoogle_site.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.whoogle_dns.zone_id
# }

# resource "aws_acm_certificate_validation" "whoogle_site" {
#   certificate_arn         = aws_acm_certificate.whoogle_site.arn
#   validation_record_fqdns = [for record in aws_route53_record.whoogle_site_certificate_validation : record.fqdn]
# }

# resource "aws_route53_record" "whoogle_site_a_record" {
#   zone_id = aws_route53_zone.whoogle_dns.zone_id
#   name    = var.cert_domain
#   type    = "A"

#   alias {
#     name                   = aws_lb.whoogle_alb.dns_name
#     zone_id                = aws_lb.whoogle_alb.zone_id
#     evaluate_target_health = true
#   }
# }
