variable "agent_count" {
  default = 1
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  default = "k8stest"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa_aks_admision.pub"
}