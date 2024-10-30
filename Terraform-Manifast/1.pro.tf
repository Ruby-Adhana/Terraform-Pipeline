terraform {
  # required_version = ">= 1.0.0"
  # required_providers {
  #   azurerm = {
  #     source = "hashicorp/azurerm"
  #     version = ">= 2.0" 
  #   }
  #   random = {
  #     source = "hashicorp/random"
  #     version = ">= 3.0"
  #   }
  #   null = {
  #     source = "hashicorp/null"
  #     version = ">= 3.0"
  #   }    
  # }
# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    # resource_group_name   = "storage-rg"
    # storage_account_name  = "storageaccount201"
    # container_name        = "container111"
    # key                   = "project-1-eastus2-terraform.tfstate"
  }  
}

provider "azurerm" {
  features {
    
  }
   subscription_id = "5732e47c-77c9-42d1-a2f7-02b1cf926f31"
   
}
provider "random" {
}

#rubyadhana
