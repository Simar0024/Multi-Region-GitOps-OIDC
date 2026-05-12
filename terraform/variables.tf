variable "project_name" {
  description = "The prefix used for all resources"
  type        = string
  default     = "gh-actions-demo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}