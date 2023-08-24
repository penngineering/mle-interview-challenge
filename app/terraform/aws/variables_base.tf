variable "aws_region" {
  type = string
}
variable "env" {
  type = string
}

variable "property" {
  type = string
}

variable "terraform_role" {
  type = string
}

variable "terraform_shared_role" {
  type = string
}
variable "log_level" {
  description = "the logging level verbosity"
  type        = string
  default     = "DEBUG"
}

variable "service_image" {
  type    = string
  default = "data-hello-world"
}

variable "service_name" {
  type    = string
  default = "sportsball-events"
}

variable "nginx_tag" {
  type    = string
  default = "dev"
}

variable "dd_port" {
  type    = string
  default = "8126"
}

variable "service_tag" {
  type = string
}
