terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.68.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}