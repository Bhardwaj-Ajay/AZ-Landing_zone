variable "location" {}
variable "env" {}
variable "app" {}
variable "rg_name" {}
variable "address_space" {}
variable "subnets" {}
variable "ngw_sku" {}

variable "ngw_subnet" {
  description = "Map of subnet names to their corresponding resource addresses to associate with NAT Gateway"
  type        = map(any)
}