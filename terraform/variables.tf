#====================================================
# Region
#====================================================
variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

#====================================================
# TF State Bucket name
#====================================================
variable "state_bucket_name" {
  description = "TF State Bucket name"
  type        = string
  default     = "yawi-tfstate-bucket-aws223"
}

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
