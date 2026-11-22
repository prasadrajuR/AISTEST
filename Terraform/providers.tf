# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.18.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0.1"
    }
  }

  required_version = ">= 1.7.2"
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}
