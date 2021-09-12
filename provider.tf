terraform {
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = "=2.46.0"
      }
    }

    backend "azurerm" {
      resource_group_name = "vitorm-terraformstate"
      storage_account_name = "vitormterraformstate"
      container_name = "terraform"
      key = "vitorm.tfstate"
    }
}

provider "azurerm" {
  features {
      
  }
}
