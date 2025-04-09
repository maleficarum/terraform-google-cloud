region = "northamerica-south1"
vpc_definition = {
  vpc_name = "main-vpc"
  vpc_description = "Main VPC"

  public_network = {
    name = "public-subnetwork"
    cidr = "10.1.0.0/24"
    description = "Public Subnet"
  }

  private_network = {
    name = "private-subnetwork"
    cidr = "10.2.0.0/24" 
    description = "Private Subnet"
  }
}

public_compute_instance = {
  name = "public-instance"
  machine_type = "e2-micro"
  zone = "northamerica-south1-c"
  storage = {
    size = 20
    image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250311"
  },
  tags = ["ssh-access"]
}

private_compute_instance = {
  name = "private-instance"
  machine_type = "e2-micro"
  zone = "northamerica-south1-c"
  storage = {
    size = 20
    image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250311"
  }
}