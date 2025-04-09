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