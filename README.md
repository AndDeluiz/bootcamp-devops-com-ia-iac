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
    git clone https://github.com/your-org/your-repo.git
    cd terraform
    ```

2. **Set up provider credentials**:
    - For DigitalOcean, export your API token:
      ```sh
      export TF_VAR_digitalocean_token=your_token_here
      ```
    - For other providers, refer to their documentation.

3. **Initialize Terraform**:
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

## Example Usage

Below is an example of how to provision resources using this Terraform code:

```hcl
# main.tf
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "web" {
  name   = "web-1"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-22-04-x64"
}
```
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
