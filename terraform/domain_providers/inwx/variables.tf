# ====================================================
# INWX Domain registrar
# sensitive variables are provided 
# in a terraform.tfvars file
# ====================================================
variable "inwx_user" {
  description = "INWX Username"
  type        = string
  sensitive   = true
}
variable "inwx_pw" {
  description = "INWX Password"
  type        = string
  sensitive   = true
}
