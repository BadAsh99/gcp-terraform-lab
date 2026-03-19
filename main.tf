provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_region
}

resource "google_compute_network" "vpc_network" {
  name                    = "ash-lab-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "ash-lab-public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
  region        = var.gcp_region
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-firewall-rule"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # WARNING: Open to the world. For labs only.
}

resource "google_compute_instance" "web" {
  name         = "ash-lab-vm"
  machine_type = "e2-micro" # Included in GCP's free tier
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {
      // The empty block assigns an ephemeral public IP
    }
  }

  tags = ["ssh-server"]
}