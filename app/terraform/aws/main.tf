data "aws_caller_identity" "this" {}

module "service_task" {
  source        = "git@github.com:penngineering/ops-terraform-data-task?ref=7b2b5cf5015ed417fe12cd039db712293ef8541e"
  internal      = false
  service_name  = var.service_name
  service_image = var.service_image
  service_tag   = var.service_tag
  aws_region    = var.aws_region
  property      = var.property
  env           = var.env
  environment_vars = {
    DD_HOST             = local.dd_agent.dd_host
    DD_PORT             = var.dd_port
    DD_TRACE_AGENT_URL  = "http://${local.dd_agent.dd_host}:${var.dd_port}"
    DD_AGENT_HOST       = local.dd_agent.dd_host
    DD_TRACE_AGENT_PORT = var.dd_port
    DD_APM_ENABLED      = "true"
    DD_TRACE_ENABLED    = "true"
    DD_SERVICE          = "${var.property}-${var.service_name}"
    SERVICE_TAG         = var.service_tag
    ENV                 = var.env
  }
  cpu         = 512
  memory      = 1024
  port        = 8000
  use_fargate = true
  nginx_tag   = var.nginx_tag
}