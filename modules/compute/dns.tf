resource "google_dns_managed_zone" "default" {
  name          = "mmmcom"
  dns_name      = "mmm.com."
  description   = "lyfedge Public DNS zone"
  force_destroy = "true"
}

resource "google_dns_record_set" "default" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_forwarding_rule.default.ip_address]
}