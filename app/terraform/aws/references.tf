provider "aws" {
  region  = var.aws_region
  assume_role {
    role_arn = var.terraform_role
  }
}

locals {
  dd_agent = data.terraform_remote_state.state["dd_agent"].outputs
  dataeng  = data.terraform_remote_state.dataeng.outputs
  flow      = data.terraform_remote_state.mlflow.outputs
}

data "terraform_remote_state" "state" {
  for_each = toset(["network", "loadbalancer", "container-runner", "dd_agent"])
  backend  = "s3"
  config = {
    bucket = "penninteractive-ops-terraform"
    region = var.aws_region
    key    = "data/${each.key}-${var.aws_region}-${var.env}/terraform/state"
  }
}

data "terraform_remote_state" "dataeng" {
  backend = "s3"
  config = {
    bucket = "penninteractive-ops-terraform"
    region = var.aws_region
    key    = "data/dataeng-${var.aws_region}-${var.env}/terraform/state"
  }
}

data "terraform_remote_state" "mlflow" {
  backend = "s3"
  config = {
    bucket = "penninteractive-ops-terraform"
    region = var.aws_region
    key    = "data-mlflow/aws-${var.aws_region}-${var.env}/terraform/state"
  }
}