terraform {
    backend "azurerm" {
        resource_group_name  = "rsg-terraform-test"
        storage_account_name = "terraformstortest"
        container_name       = "terraform-infra"
        key                  = "terraform-test.tfstate"
    }
}
    
module "env" {
    source = "../../../modules/environment"
    
    environment = "test"
    tags = {
        "Environment" : "Test"
    }
}
