/*terraform {
    required_version = ">=1.9.7"
    required_providers {

        google = {
            source  = "hashicorp/google"
            version = "~> 6.29.0"
        }

    }
}*/

resource "google_compute_network" "main_vpc" {
  name                    = var.vpc_definition.vpc_name
  auto_create_subnetworks = false
  project                 = var.project
  routing_mode            = "REGIONAL"
  description             = var.vpc_definition.vpc_description
}

resource "google_compute_subnetwork" "public_subnet" {
  name                     = var.vpc_definition.public_network.name
  region                   = var.region
  network                  = google_compute_network.main_vpc.id
  ip_cidr_range            = var.vpc_definition.public_network.cidr
  description              = var.vpc_definition.public_network.description
  private_ip_google_access = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = var.vpc_definition.private_network.name
  region                   = var.region
  network                  = google_compute_network.main_vpc.id
  ip_cidr_range            = var.vpc_definition.private_network.cidr
  private_ip_google_access = true
  description              = var.vpc_definition.private_network.description
}