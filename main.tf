module "common" {
  source = "./000-common/"

  location = "West Europe"
}

module "aks" {
  source = "./010-aks"

  location = "West Europe"

  agent_count = 3
  dns_prefix = "vitorm-k8s"
  cluster_name = "vitorm-k8s"
  resource_group_name = "${module.common.resource-group-name}"
  log_analytics_workspace_name = "vitorm-container-insights-workspace"
  log_analytics_workspace_sku = "PerGB2018"
  vm_size = "Standard_D2_v2"

  depends_on = [
    module.common
  ]
}

module "munin" {
  source = "./100-munin/"

  depends_on = [
    module.common
  ]
}
