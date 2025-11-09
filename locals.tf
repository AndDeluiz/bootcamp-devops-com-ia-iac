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