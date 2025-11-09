# Output definitions
output "k8s_clusters" {
  value = { for k, v in digitalocean_kubernetes_cluster.this : k => {
    id       = v.id
    endpoint = v.endpoint
    status   = v.status
    nodepool = v.node_pool[0].name
    nodes    = v.node_pool[0].nodes[*].name
    }
  }
}

output "kubeconfig" {
  value = { for k, v in digitalocean_kubernetes_cluster.this : k => {
    kubeconfig = v.kube_config[0].raw_config
    }
  }
  sensitive = true
}

output "db_clusters" {
  value = { for k, v in digitalocean_database_cluster.this : k => {
    id          = v.id
    name        = v.name
    database    = v.database
    engine      = v.engine
    version     = v.version
    nodes       = v.node_count
    size        = v.size
    region      = v.region
    }
  }
}

output "db_credentials" {
  value = { for k, v in digitalocean_database_cluster.this : k => {
    id          = v.id
    database    = v.database
    user        = v.user
    password    = v.password
    uri         = v.uri
    private_uri = v.private_uri
    }
  }
  sensitive = true
}