terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.59.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "rg_infra"
  #   storage_account_name = "storageinfra"
  #   container_name       = "contenerinfra"
  #   key                  = "brik.tfstate"

  # }
}

provider "azurerm" {
  features {}
  subscription_id = "538f56b2-294c-4e41-a854-7ab1b5d5ad51"
}