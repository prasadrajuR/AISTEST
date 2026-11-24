terraform {
   backend "azurerm" {
    resource_group_name  = "DestinationRG"
    storage_account_name = "prasadrajuterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             =  true
    use_azuread_auth     =  true

  }
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
            definition = jsondecode(file("${path.module}/../workflow.json")).definition
            state = "disabled"  
        }

    }
  
}

