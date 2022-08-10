terraform {
  required_version = ">= 1.2.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-BACKEND"
    #storage_account_name = "sadevopsterraform2806"
    storage_account_name = "sadevopsterraform1205"
    container_name = "remote-state"
    key            = "ambiente-jack/terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}

