terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "random_integer" "random" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${var.nom}-${random_integer.random.result}"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "asp-${var.nom}-${random_integer.random.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "webapp-${var.nom}-${random_integer.random.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  site_config {
    linux_fx_version = "JAVA|java17"
  }
}


