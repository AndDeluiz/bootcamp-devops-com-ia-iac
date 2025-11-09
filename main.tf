
# Create a new Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "this" {
  for_each                         = local.k8s_cluster
  name                             = local.k8s_cluster["prd"].cluster_name
  region                           = local.k8s_cluster["prd"].cluster_region
  version                          = local.k8s_cluster["prd"].cluster_version
  ha                               = local.k8s_cluster["prd"].cluster_ha
  destroy_all_associated_resources = "true"
  auto_upgrade                     = false
  tags                             = local.k8s_cluster["prd"].cluster_tags
  vpc_uuid                         = local.k8s_cluster["prd"].vpc_uuid

  node_pool {
    name       = local.k8s_cluster["prd"].np_name
    size       = local.k8s_cluster["prd"].np_size
    node_count = local.k8s_cluster["prd"].np_node_count
    auto_scale = local.k8s_cluster["prd"].np_autoscale
    tags       = local.k8s_cluster["prd"].np_tags
  }
}

# PostgreSQL Database Cluster
resource "digitalocean_database_cluster" "this" {
  for_each             = local.db_pgsql
  name                 = local.db_pgsql[each.key].name
  engine               = local.db_pgsql[each.key].engine
  version              = local.db_pgsql[each.key].version
  region               = local.db_pgsql[each.key].region
  size                 = local.db_pgsql[each.key].size
  node_count           = local.db_pgsql[each.key].node_count
  private_network_uuid = local.db_pgsql[each.key].vpc_uuid
  tags                 = local.db_pgsql[each.key].tags
}