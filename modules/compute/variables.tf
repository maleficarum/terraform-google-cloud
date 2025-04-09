variable "public_subnetwork" {
  type        = string
  description = "Public Subnetwork to target the deployment"
}

variable "private_subnetwork" {
  type        = string
  description = "Private Subnetwork to target the deployment"
}

variable "private_compute_instance" {
  description = "Compute instance definition"
  type = object({
    name            = string
    machine_type    = string
    zone            = string
    storage = object({
      size  = number
      image = string
    })
  })
}

variable "public_compute_instance" {
  description = "Compute instance definition"
  type = object({
    name            = string
    machine_type    = string
    zone            = string
    storage = object({
      size  = number
      image = string
    })
    tags = list(string)
  })
}

variable "service_account" {
  type = string
  description = "Service Account"
}