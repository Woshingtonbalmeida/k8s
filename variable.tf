variable "location" {
  description = "Variavel indica a região onde os recursos serão criado"
  type        = string
  default     = "East US"
}
variable "vm-name" {
  type    = list(any)
  default = ["RANCHER", "CLUSTER-1", "CLUSTER-2", "CLUSTER-3", "WORK-1", "WORK-2"]
}
variable "disk_size_gb" {
  type    = list(any)
  default = ["32", "32", "32", "32", "32", "32"]
}
