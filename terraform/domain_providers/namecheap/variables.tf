# ====================================================
# Namecheap Domain registrar
# sensitive variables are provided 
# in a terraform.tfvars file
# ====================================================
variable "namecheap_api_username" {
  description = "Namecheap APIUsername"
  type        = string
  sensitive   = true
}
variable "namecheap_api_key" {
  description = "Namecheap APIKey"
  type        = string
  sensitive   = true
}
