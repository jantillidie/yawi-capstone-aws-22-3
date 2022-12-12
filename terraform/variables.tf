#====================================================
# Whoogle Container
#====================================================
variable "container_port" {
  description = "Standard Whoogle container port"
  type        = number
  default     = 5000
}

#====================================================
# Route 53
#====================================================
variable "domain_name" {
  description = "Domain for Whoolge Site"
  type        = string
  default     = "whoogledev.site"
}

#====================================================
# ACM
#====================================================
variable "cert_domain" {
  description = "Base domain for TLS"
  type        = string
  default     = "whoogledev.site"
}

#====================================================
# SNS E-Mail
#====================================================
variable "sns_email" {
  description = "E-Mail for SNS Cloudwatch Alarms"
  type        = string
  sensitive   = true
}
