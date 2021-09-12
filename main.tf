module "common" {
  source = "./000-common/"
}

module "aks" {
  source = "./010-aks"

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
