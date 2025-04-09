output "private_subnetwork" {
  value       = google_compute_subnetwork.private_subnet.id
  description = "Private Subnetwork"
}

output "public_subnetwork" {
  value       = google_compute_subnetwork.public_subnet.id
  description = "Public Subnetwork"
}