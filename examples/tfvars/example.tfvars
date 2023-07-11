helm_repository = "https://wandb.github.io/helm-charts"
helm_chart_version = "0.8.0"


launch_config = <<EOF
queues: [demo-queue]
entity: demo-team
max_jobs: 5
max_schedulers: 8
environment:
  type: azure
registry:
  type: acr
  uri: https://demo.azurecr.io/myrepo
builder:
  type: kaniko
  build-context-store: https://demo.blob.core.windows.net/wandb
EOF


subscription_id = "your-azure-subscription-id"
agent_labels = {
  "azure.workload.identity/use" = "true"
}

agent_api_key = "local-fc8..."
agent_image = "wandb/launch-agent-dev:f0cf9e0a"
agent_image_pull_policy = "Always"

agent_resources = {
  limits = {
    cpu = "1"
    memory = "1Gi"
  }
}

namespace = "wandb"

additional_target_namespaces = ["default", "wandb"]

base_url = "https://blasczyk-azure.sandbox-azure.wandb.ml"

volcano = false

git_creds = ""

service_account_annotations = {
  # "iam.gke.io/gcp-service-account" = ""
  "azure.workload.identity/client-id" = "688fafb0-0a35-495d-a40c-eefdb3196cd1"
}

azure_storage_access_key = "uyF1cgGi..."
