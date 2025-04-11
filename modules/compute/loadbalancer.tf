resource "google_compute_instance_group" "private_group" {
  name      = "staging-instance-group"
  zone      = var.public_compute_instance.zone
  instances = [ google_compute_instance.private_compute_instance.id ]

  named_port {
    name = "http"
    port = "80"
  }
/*
  named_port {
    name = "https"
    port = "443"
  }
*/

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_http_health_check" "default" {
  name               = "web-health-check"
  request_path       = "/"
  check_interval_sec = 60
  timeout_sec        = 5
  port = 80
}

resource "google_compute_backend_service" "default" {
  name        = "web-backend-service"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = google_compute_instance_group.private_group.id
  }

  health_checks = [google_compute_http_health_check.default.id]
}

resource "google_compute_url_map" "default" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "web-http-proxy"
  url_map = google_compute_url_map.default.id
}

/*
resource "google_compute_global_forwarding_rule" "default" {
  name       = "web-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}
*/

resource "google_compute_global_forwarding_rule" "default" {
  name       = "https-forwarding-rule"
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
}

resource "google_compute_ssl_certificate" "default" {
  name_prefix = "ss-cert"
  description = "Self Signed Certificate"
  private_key = file("resources/private.key")
  certificate = file("resources/certificate.crt")

  lifecycle {
    create_before_destroy = true
    ignore_changes = [private_key, certificate]   
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = "https-lb-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_ssl_certificate.default.id]
  
  # Optional: Enable HTTP/3 (QUIC)
  quic_override = "ENABLE"
}
