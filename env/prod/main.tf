terraform {
    backend "azurerm" {
        resource_group_name  = "rsg-terraform-prod"
        storage_account_name = "terraformstorprod"
        container_name       = "terraform-infra"
        key                  = "terraform-prod.tfstate"
    }
}
    
module "env" {
    source = "../../../modules/environment"
    
    environment = "prod"
    tags = {
        "Environment" : "Production"
    }
}
