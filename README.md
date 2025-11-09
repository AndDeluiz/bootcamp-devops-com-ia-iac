# Infrastructure Documentation

This repository contains Terraform code for provisioning infrastructure. The following documentation describes the code, its dependencies, requirements, configuration, usage, and examples.

## Overview

The Terraform code in this folder is designed to automate the deployment and management of cloud resources. It leverages Terraform as the Infrastructure as Code (IaC) tool and may integrate with external providers such as DigitalOcean via `doctl`.

## External Dependencies

- **terraform**: Required for running and applying the infrastructure code. [Install Terraform](https://www.terraform.io/downloads.html). Should also work with Opentofu but hasn't been tested.
- **doctl** (optional): Command-line tool for managing DigitalOcean resources. [Install doctl](https://github.com/digitalocean/doctl).
- **tfenv** (optional): Terraform version manager for easily switching between Terraform versions. [Install tfenv](https://github.com/tfutils/tfenv).
- **direnv** (optional): Environment variable manager for loading project-specific environment variables automatically. [Install direnv](https://direnv.net/).

## Tools

- Terraform v1.10 or higher (recommended to manage via tfenv)
- doctl (if DigitalOcean provider is used)
- tfenv (for managing Terraform versions)
- direnv (for managing environment variables)
- API credentials for the cloud provider (e.g., DigitalOcean API token)
- Internet access for downloading provider plugins

## Configuration

1. **Clone the repository**:
    ```sh
    git clone https://github.com/AndDeluiz/bootcamp-devops-com-ia-iac.git
    ```

2. **Set up provider credentials**:
    - For DigitalOcean, export your API token:
      ```sh
      export TF_VAR_digitalocean_token=your_token_here
      ```
    - For other providers, refer to their documentation.

3. **Configure `locals.tf` file according to your needs**:
    ```hcl
    locals {
      default_region = "nyc1"
      default_tags   = "project:bootcamp-devops-com-ia" # separate tags with commas if more than one tag is needed

      k8s_cluster = {
        "prd" = {
          cluster_name    = "doks-${local.default_region}-prd-cluster-01"
          cluster_region  = local.default_region
          cluster_version = "1.33.1-do.5" # list versions with "doctl kubernetes options versions" command
          cluster_ha      = false
          cluster_tags    = ["env:prd", "${local.default_tags}"]
          np_name         = "doks-${local.default_region}-prd-cluster-01-np-001"
          np_size         = "s-2vcpu-4gb" # list sizes with "doctl compute size list" command
          np_node_count   = 2
          np_autoscale    = false
          np_tags         = ["env:prd", "nodetype:std", local.default_tags]
          vpc_uuid        = digitalocean_vpc.this.id
        }
      }

      db_pgsql = {
        "prd" = {
          name       = "dodb-${local.default_region}-prd-pgsql-cluster-01"
          engine     = "pg"
          size       = "db-s-1vcpu-1gb" # list sizes with "doctl database options slugs --engine pg" command
          version    = "17"
          region     = local.default_region
          node_count = 1
          vpc_uuid   = digitalocean_vpc.this.id
          tags       = ["env:prd", local.default_tags]
        }
        "hml" = {
          name       = "dodb-${local.default_region}-hml-pgsql-cluster-01"
          engine     = "pg"
          size       = "db-s-1vcpu-1gb" # list sizes with "doctl database options slugs --engine pg" command
          version    = "17"
          region     = local.default_region
          node_count = 1
          vpc_uuid   = digitalocean_vpc.this.id
          tags       = ["env:hml", "${local.default_tags}"]
        }
      }
    }
    ```

4. **Initialize Terraform**:
    ```sh
    terraform init
    ```

## Applying the Infrastructure

1. **Review the plan**:
    ```sh
    terraform plan
    ```

2. **Apply the changes**:
    ```sh
    terraform apply
    ```
    Confirm the action when prompted.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.68.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_database_cluster.this](https://registry.terraform.io/providers/digitalocean/digitalocean/2.68.0/docs/resources/database_cluster) | resource |
| [digitalocean_kubernetes_cluster.this](https://registry.terraform.io/providers/digitalocean/digitalocean/2.68.0/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_vpc.this](https://registry.terraform.io/providers/digitalocean/digitalocean/2.68.0/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_digitalocean_token"></a> [digitalocean\_token](#input\_digitalocean\_token) | Digital Ocean API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_clusters"></a> [db\_clusters](#output\_db\_clusters) | n/a |
| <a name="output_db_credentials"></a> [db\_credentials](#output\_db\_credentials) | n/a |
| <a name="output_k8s_clusters"></a> [k8s\_clusters](#output\_k8s\_clusters) | Output definitions |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
<!-- END_TF_DOCS -->

## Notes

- State files (`terraform.tfstate*`) and `.terraform*` directories are ignored and should not be committed.
- Always review changes with `terraform plan` before applying.
- Refer to individual `.tf` files for specific resource configurations.

## References

- [Terraform Documentation](https://www.terraform.io/docs)
- [doctl Documentation](https://docs.digitalocean.com/reference/doctl/)
- [tfenv Documentation](https://github.com/tfutils/tfenv)
- [direnv Documentation](https://direnv.net/)
