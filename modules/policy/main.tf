data "azurerm_client_config" "current" {}

resource "azurerm_resource_group_policy_assignment" "allowed_location" {
  name                 = "allowed-location-policy"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  display_name         = "Allowed locations"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = [var.location]
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "require_tag_environment" {
  name                 = "require-tag-environment"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
  display_name         = "Require tag Environment"

  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "require_tag_project" {
  name                 = "require-tag-project"
  resource_group_id    = var.resource_group_id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
  display_name         = "Require tag Project"

  parameters = jsonencode({
    tagName = {
      value = "Project"
    }
  })
}