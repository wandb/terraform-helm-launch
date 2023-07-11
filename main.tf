locals {
  service_account_annotations_sets = [
    for k, v in var.service_account_annotations : {
      name  = "serviceAccount.annotations.${replace(k, ".", "\\.")}"
      value = v
      type  = "string"
    }
  ]
}

resource "helm_release" "launch_agent" {
  name       = "wandb-launch-agent"
  repository = var.helm_repository
  chart      = "launch-agent"
  version    = var.helm_chart_version

  namespace = var.namespace

  recreate_pods    = true
  max_history      = 3
  create_namespace = true
  wait             = true
  reset_values     = true
  force_update     = true

  lint = true

  dynamic "set" {
    for_each = var.agent_labels
    content {
      name  = "agent.labels.${replace(set.key, ".", "\\.")}"
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "agent.apiKey"
    value = var.agent_api_key
  }

  set {
    name  = "agent.image"
    value = var.agent_image
  }

  set {
    name  = "agent.imagePullPolicy"
    value = var.agent_image_pull_policy
  }

  dynamic "set" {
    for_each = var.agent_resources.limits
    content {
      name  = "agent.resources.limits.${set.key}"
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "namespace"
    value = var.namespace
  }

  set {
    name  = "baseUrl"
    value = var.base_url
  }

  set_list {
    name  = "additionalTargetNamespaces"
    value = var.additional_target_namespaces
  }

  set {
    name  = "launchConfig"
    value = var.launch_config
  }

  set {
    name  = "volcano"
    value = var.volcano
  }

  set {
    name  = "gitCreds"
    value = var.git_creds
  }

  dynamic "set" {
    for_each = local.service_account_annotations_sets
    content {
      name  = set.value["name"]
      value = set.value["value"]
      type  = set.value["type"]
    }
  }

  set {
    name  = "azureStorageAccessKey"
    value = var.azure_storage_access_key
  }
}
