# =====================================================================
# Variables configurables
# =====================================================================

variable "location" {
  description = "Región de Azure donde se crean los recursos (equivale a 'region' en AWS)."
  type        = string
  default     = "northcentralus"
}

variable "cluster_name" {
  description = "Nombre del cluster de AKS."
  type        = string
  default     = "k8stest"
}

variable "vm_size" {
  description = "Tamaño de VM de los nodos (equivale a 'instance_type' en AWS). Ej: Standard_B2s."
  type        = string
  default     = "Standard_B2s"
}

variable "node_count" {
  description = "Cantidad de nodos del pool de trabajo (equivale a 'node_count' en AWS)."
  type        = number
  default     = 1
}

variable "use_spot_instances" {
  description = "Usar instancias Spot para los nodos de trabajo (equivale a 'use_spot_instances' en AWS)."
  type        = bool
  default     = false
}

variable "disk_size_gb" {
  description = "Tamaño del disco de OS de cada nodo en GB (equivale a 'disk_size_gb' en AWS)."
  type        = number
  default     = 20
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes del cluster."
  type        = string
  default     = "1.35"
}

variable "dns_prefix" {
  description = "Prefijo DNS del cluster de AKS."
  type        = string
  default     = "k8stest"
}

variable "ssh_public_key" {
  description = "Ruta a la llave pública SSH para el acceso a los nodos."
  type        = string
  default     = "~/.ssh/id_rsa_aks_admision.pub"
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  description = "appId del Service Principal de Azure."
  type        = string
  default     = ""
}

variable "aks_service_principal_client_secret" {
  description = "password/secret del Service Principal de Azure."
  type        = string
  default     = ""
  sensitive   = true
}
