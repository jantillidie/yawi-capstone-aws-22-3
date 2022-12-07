#====================================================
# Whoogle Container
#====================================================
variable "container_port" {
  description = "Standard Whoogle container port"
  type        = number
  default     = 5000
}

#====================================================
# Namecheap Domain registrar
# sensitive variables are provided 
# in a terraform.tfvars file
#====================================================
# variable "namecheap_api_username" {
#   description = "Namecheap APIUsername"
#   type        = string
#   sensitive   = true
# }
# variable "namecheap_api_key" {
#   description = "Namecheap APIKey"
#   type        = string
#   sensitive   = true
# }

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
