# terraform-helm-launch

`helm-launch` is a Terraform module designed to deploy `wandb launch` into a Kubernetes cluster. This module simplifies the process of setting up and managing the deployment of `wandb launch` in your Kubernetes environment.

## Prerequisites

- Terraform v1.0+
- Kubernetes cluster
- kubectl
- Helm v3+

## Usage

To use the `launch-helm` module, you will need to define several variables in a `.tfvars` file or in your Terraform configuration. These variables are then passed into the module.

1. Create a `.tfvars` file and fill out the required fields and optionally some of the optional fields. Here's an example:

```hcl
# Required
helm_chart_version = "0.8.0"
agent_image   = "wandb/launch-agent-dev:f0cf9e0a"
base_url      = "http://host.docker.internal:8080"
agent_api_key = "local-9ff3...."
launch_config = <<EOF
  queues: [docker-desktop]
  entity: docker-desktop
  max_jobs: 5
  max_schedulers: 8
  environment:
    type: local
  registry:
    type:
    uri:
  builder:
    type: noop
    build-context-store: 
EOF

#optional
agent_labels = {
  app = "wandb"
}
additional_target_namespaces = ["default"]
```

2. Use the `launch-helm` module in your Terraform configuration:

```hcl
module "launch-helm" {
  source = "path/to/launch-helm"

  helm_repository              = var.helm_repository
  helm_chart_version           = var.helm_chart_version
  agent_labels                 = var.agent_labels
  agent_api_key                = var.agent_api_key
  agent_image                  = var.agent_image
  agent_image_pull_policy      = var.agent_image_pull_policy
  namespace                    = var.namespace
  base_url                     = var.base_url
  additional_target_namespaces = var.additional_target_namespaces
  launch_config                = var.launch_config
  volcano                      = var.volcano
  git_creds                    = var.git_creds
  service_account_annotations  = var.service_account_annotations
  azure_storage_access_key     = var.azure_storage_access_key
}
```

3. Run `terraform init` to initialize the Terraform working directory.
4. Run `terraform apply -var-file="your.tfvars"` to apply the changes.

Replace `path/to/launch-helm` with the path to the `launch-helm` module directory or repository, and set the required variables according to your needs.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.10 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_target_namespaces"></a> [additional\_target\_namespaces](#input\_additional\_target\_namespaces) | Additional target namespaces that the launch agent can deploy into | `list(string)` | <pre>[<br>  "wandb",<br>  "default"<br>]</pre> | no |
| <a name="input_agent_api_key"></a> [agent\_api\_key](#input\_agent\_api\_key) | W&B API key | `string` | n/a | yes |
| <a name="input_agent_image"></a> [agent\_image](#input\_agent\_image) | Container image to use for the agent | `string` | n/a | yes |
| <a name="input_agent_image_pull_policy"></a> [agent\_image\_pull\_policy](#input\_agent\_image\_pull\_policy) | Image pull policy for agent image | `string` | `"Always"` | no |
| <a name="input_agent_labels"></a> [agent\_labels](#input\_agent\_labels) | Agent labels | `map(string)` | `{}` | no |
| <a name="input_agent_resources"></a> [agent\_resources](#input\_agent\_resources) | Resources block for the agent spec | <pre>object({<br>    limits = map(string)<br>  })</pre> | <pre>{<br>  "limits": {<br>    "cpu": "1",<br>    "memory": "1Gi"<br>  }<br>}</pre> | no |
| <a name="input_azure_storage_access_key"></a> [azure\_storage\_access\_key](#input\_azure\_storage\_access\_key) | Set to access key for azure storage if using kaniko with azure | `string` | `""` | no |
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | W&B api url | `string` | n/a | yes |
| <a name="input_git_creds"></a> [git\_creds](#input\_git\_creds) | The contents of a git credentials file | `string` | `""` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm chart version | `string` | n/a | yes |
| <a name="input_helm_repository"></a> [helm\_repository](#input\_helm\_repository) | Helm repository URL | `string` | `"https://wandb.github.io/helm-charts"` | no |
| <a name="input_launch_config"></a> [launch\_config](#input\_launch\_config) | The literal contents of your launch agent config | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy launch agent into | `string` | `"wandb"` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Annotations for the wandb service account | `map(string)` | `{}` | no |
| <a name="input_volcano"></a> [volcano](#input\_volcano) | Set to false to disable volcano install | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release_chart"></a> [helm\_release\_chart](#output\_helm\_release\_chart) | The Helm release |
| <a name="output_helm_release_status"></a> [helm\_release\_status](#output\_helm\_release\_status) | The status of the Helm release |

<!-- END_TF_DOCS -->

## Examples

For more examples on how to use the `launch-helm` module, please refer to the [examples](./examples) directory.

## Contributing

We welcome contributions to the `launch-helm` module. Please submit a pull request with your changes, and ensure that your code follows the existing code style and conventions.