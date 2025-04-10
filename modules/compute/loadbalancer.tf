resource "google_compute_instance_group" "private_group" {
  name      = "staging-instance-group"
  zone      = "northamerica-south1-c"
  instances = [ google_compute_instance.private_compute_instance.id ]
  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_http_health_check" "default" {
  name               = "web-health-check"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
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

resource "google_compute_global_forwarding_rule" "default" {
  name       = "web-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}