resource "digitalocean_vpc" "this" {
  name        = "vpc-${local.default_region}-bootcamp-01"
  region      = local.default_region
  description = "VPC for Bootcamp DevOps com IA"
}