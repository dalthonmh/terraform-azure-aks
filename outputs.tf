output "resource_group_name" {
  description = "Nombre del grupo de recursos donde vive el cluster."
  value       = azurerm_resource_group.rg-network-aks-admision.name
}

output "cluster_name" {
  description = "Nombre del cluster de AKS."
  value       = azurerm_kubernetes_cluster.k8s.name
}

output "get_credentials_command" {
  description = "Comando para configurar kubectl y apuntarlo a este cluster."
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.rg-network-aks-admision.name} --name ${azurerm_kubernetes_cluster.k8s.name} --overwrite-existing"
}

# Uso: terraform output -raw kube_config > ~/.kube/config-aks
output "kube_config" {
  description = "Kubeconfig completo del cluster (sensible)."
  value       = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive   = true
}
