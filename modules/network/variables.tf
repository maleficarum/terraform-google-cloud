variable "project" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region to deploy the resources"
}

variable "vpc_definition" {
  description = "VPC Definition"
  type = object({
    vpc_name        = string
    vpc_description = string
    public_network = object({
      name        = string
      cidr        = string
      description = string
    })
    private_network = object({
      name        = string
      cidr        = string
      description = string
    })
  })
}