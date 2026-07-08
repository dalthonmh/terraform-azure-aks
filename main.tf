# Creación de grupo de recursos
resource "azurerm_resource_group" "rg-network-aks-admision" {
  name     = "aks-admision"
  location = "northcentralus"
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
  tags                = {
    Environment = "Development"
  }

  default_node_pool {
    name       = "k8spool"
    vm_size    = "Standard_B2ls_v2"

    node_count = var.agent_count
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