resource "google_compute_firewall" "ssh_rule" {
  name = "ssh-rule"
  network = google_compute_network.main_vpc.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["ssh-access"]
  source_ranges = ["0.0.0.0/0"]
}