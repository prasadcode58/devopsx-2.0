terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "devopsx_network" {
  name = "devopsx-network"
}

resource "docker_container" "devopsx_terraform" {
  name  = "devopsx-terraform"
  image = "devopsx-2.0:1.0"

  ports {
    internal = 5000
    external = 5001
  }

  networks_advanced {
    name = docker_network.devopsx_network.name
  }
}
