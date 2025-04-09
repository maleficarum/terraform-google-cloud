resource "google_compute_instance" "private_compute_instance" {
  tags = var.public_compute_instance.tags
  metadata = {
    ssh-keys = "ivan:${file("~/.ssh/id_rsa.pub")}"
  }
  boot_disk {
    auto_delete = true
    device_name = var.private_compute_instance.name

    initialize_params {
      image = var.private_compute_instance.storage.image
      size  = var.private_compute_instance.storage.size
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = var.private_compute_instance.machine_type
  name         = var.private_compute_instance.name

  network_interface {
    /*access_config {
      network_tier = "STANDARD"
    }*/

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = var.private_subnetwork
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = var.service_account
    scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only", 
        "https://www.googleapis.com/auth/logging.write", 
        "https://www.googleapis.com/auth/monitoring.write", 
        "https://www.googleapis.com/auth/service.management.readonly", 
        "https://www.googleapis.com/auth/servicecontrol", 
        "https://www.googleapis.com/auth/trace.append",
        "cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = var.private_compute_instance.zone


}


resource "google_compute_instance" "public_compute_instance" {
  tags = var.public_compute_instance.tags

  metadata = {
    ssh-keys = "ivan:${file("~/.ssh/id_rsa.pub")}"
  }
  boot_disk {
    auto_delete = true
    device_name = var.public_compute_instance.name

    initialize_params {
      image = var.public_compute_instance.storage.image
      size  = var.public_compute_instance.storage.size
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = var.public_compute_instance.machine_type
  name         = var.public_compute_instance.name

  network_interface {
    access_config {
      network_tier = "STANDARD"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = var.public_subnetwork
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = var.service_account
    scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only", 
        "https://www.googleapis.com/auth/logging.write", 
        "https://www.googleapis.com/auth/monitoring.write", 
        "https://www.googleapis.com/auth/service.management.readonly", 
        "https://www.googleapis.com/auth/servicecontrol", 
        "https://www.googleapis.com/auth/trace.append",
        "cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = var.public_compute_instance.zone


}