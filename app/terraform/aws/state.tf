terraform {
  required_version = ">= 0.15.3"

  required_providers {
    archive = {
      source = "hashicorp/archive"
      version = "~> 2.2.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.40.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.1.0"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    encrypt              = true
    region               = "eu-west-1"
    bucket               = "penninteractive-ops-terraform"
    workspace_key_prefix  = "data/data-interview-challenge-api"
    key                  = "terraform/state"
    dynamodb_table       = "terraform-state-lock"
  }
}