
provider "google" {
  credentials = file("sarah-GA.json")
  project     = "nathael-dev"
  region      = "europe-west1"
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "europe-west1"

  # Configuration minimale du cluster
  initial_node_count = 3

  node_config {
    machine_type = "e2-medium" # 2 vCPU, 4 Go RAM
    disk_size_gb = 100
  }

  # Activer l'autoscaling
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum = 1
      maximum = 32
    }
    resource_limits {
      resource_type = "memory"
      minimum = 1 # en Go
      maximum = 128 # en Go
    }
  }
}
