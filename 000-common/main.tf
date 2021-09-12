resource "azurerm_resource_group" "vitorm" {
    name        = "vitorm-resources"
    location    = var.location
}

resource "azurerm_virtual_network" "vitorm" {
  name                  = "vitorm-network"
  resource_group_name   = azurerm_resource_group.vitorm.name
  location              = azurerm_resource_group.vitorm.location
  address_space         = [ "10.0.0.0/16" ]
}
