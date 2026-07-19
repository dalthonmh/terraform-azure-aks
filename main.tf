# Creación de grupo de recursos
resource "azurerm_resource_group" "rg-network-aks-admision" {
  name     = "aks-admision"
  location = var.location
}

# Creación de red virtual
resource "azurerm_virtual_network" "vnet-aks-admision" {
  name                = "aks-admision-vnet"
  address_space       = ["10.30.0.0/24"]
  location            = azurerm_resource_group.rg-network-aks-admision.location
  resource_group_name = azurerm_resource_group.rg-network-aks-admision.name
}

# Creación de subred
resource "azurerm_subnet" "subnet-front" {
  name                 = "front"
  resource_group_name  = azurerm_resource_group.rg-network-aks-admision.name
  virtual_network_name = azurerm_virtual_network.vnet-aks-admision.name
  address_prefixes     = ["10.30.0.0/28"]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg-network-aks-admision.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg-network-aks-admision.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  tags = {
    Environment = "Development"
  }

  default_node_pool {
    name            = "k8spool"
    vm_size         = var.vm_size
    os_disk_size_gb = var.disk_size_gb

    node_count = var.use_spot_instances ? 1 : var.node_count
  }
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }
}

# Pool de nodos Spot (equivale a use_spot_instances = true en AWS).
# Solo se crea cuando var.use_spot_instances es true.
resource "azurerm_kubernetes_cluster_node_pool" "spot" {
  count = var.use_spot_instances ? 1 : 0

  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.vm_size
  os_disk_size_gb       = var.disk_size_gb
  node_count            = var.node_count

  priority        = "Spot"
  eviction_policy = "Delete"
  spot_max_price  = -1 # -1 = pagar hasta el precio on-demand (sin límite de tope)

  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
}