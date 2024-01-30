provider "azurerm" {
    features {
      
    }
  
}
resource "azurerm_resource_group" "pk" {
    name = "pallavi-rg"
    location = "eastus"
}
resource "azurerm_kubernetes_cluster" "aks" {
    name = "pallavi-aks"
    resource_group_name = azurerm_resource_group.pk.name
    location = azurerm_resource_group.pk.location
    dns_prefix = "my-aks-cluster"
    default_node_pool {
      name = "default"
      node_count = 1
      vm_size = "Standard_DS2_v2"
    }
    
    tags = {
      Environment = "Production"
    }
}
