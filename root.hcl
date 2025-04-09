locals {
    envlocals =  read_terragrunt_config("env.hcl")
    //tfvars = jsondecode(read_tfvars_file("variables.tfvars"))

    //environment = local.envlocals.locals.environment
}

generate "terraform" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

    terraform {
        required_version = ">=1.9.7"
        required_providers {

        google = {
            source  = "hashicorp/google"
            version = "~> 6.29.0"
        }

        }
    }

    provider "google" {
    project     = "${local.envlocals.locals.project}"
    region      = "${local.envlocals.locals.region}"
    }

  EOF
}