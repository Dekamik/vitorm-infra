resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "vitorm-k8s" {
  name                  = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  sku                   = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "vitorm-k8s" {
  solution_name = "Vitorm Container Insights"
  location = azurerm_log_analytics_workspace.vitorm-k8s.location
  resource_group_name = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.vitorm-k8s.id
  workspace_name = azurerm_log_analytics_workspace.vitorm-k8s.name

  plan {
      publisher = "Microsoft"
      product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                  = var.cluster_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  dns_prefix            = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name        = "agentpool"
    node_count  = var.agent_count
    vm_size     = var.vm_size
  }

  addon_profile {
    oms_agent {
        enabled = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.vitorm-k8s.id
    }
  }

  network_profile {
    load_balancer_sku   = "Standard"
    network_plugin      = "kubenet"
  }
}