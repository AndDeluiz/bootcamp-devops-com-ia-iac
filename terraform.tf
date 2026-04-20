terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.84.1"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}