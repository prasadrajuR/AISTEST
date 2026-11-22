terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source = "azure/azapi"
      version = "~> 2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "DestinationRG"
    storage_account_name = "prasadrajuterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f3e5c1d0-2b4a-4c8e-9f3b-1a2b3c4d5e6f"
}


data "azurerm_resource_group" "destination" {
  name                = "DestinationRG"
  
}

resource "azapi_resource" "logicapp" {
    type = "Microsoft.Logic/workflows@2019-05-01"
    name     = "test"
    parent_id = data.azurerm_resource_group.destination.id
    location = data.azurerm_resource_group.destination.location
    body = {
        properties = {
            definition = jsoncode(file("${path.module}/../workflow.json"))
            state = "disabled"  
        }

    }
  
}

