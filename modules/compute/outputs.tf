
output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.default.ip_address
  description = "value"
}

output "private_hostname" {
  value       = google_compute_instance.private_compute_instance.hostname
  description = "Hostname"
}