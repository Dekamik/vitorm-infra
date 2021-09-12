variable "log_analytics_workspace_name" {
  description   = ""
  type          = string
  default       = "vitorm-container-insights"
}

variable "location" {
  description   = ""
  type          = string
}

variable "resource_group_name" {
  description   = ""
  type          = string
}

variable "log_analytics_workspace_sku" {
  description = ""
  type        = string
}

variable "cluster_name" {
  description   = ""
  type          = string
}

variable "dns_prefix" {
  description   = ""
  type          = string
}

variable "ssh_public_key" {
  description   = ""
  type          = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "agent_count" {
  description   = ""
  type          = string
}

variable "vm_size" {
  description   = ""
  type          = string
}
