include "env" {
  path = "./env.hcl"
  expose = true
  merge_strategy = "no_merge"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
}

locals {
    envlocals =  read_terragrunt_config("env.hcl")
    //tfvars = jsondecode(read_tfvars_file("variables.tfvars"))

    //environment = local.envlocals.locals.environment
}

terraform {
  source = "../../../modules//network"

  include_in_copy = ["variables.tfvars"]

  before_hook "tflint" {
    commands     = ["apply", "plan"]
    execute      = ["tflint"]
  }

  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "destroy"
    ]

    required_var_files = ["variables.tfvars"]
  }
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = local.envlocals.locals.backend_bucket
    prefix         = "${path_relative_to_include("root")}"
  }
}