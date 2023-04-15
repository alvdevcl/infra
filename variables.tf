variable "region" {
  type = string
  description = "aws Region"
  default = "us-east-1"
}

variable "cidr_block" {
  type = string
  description = "(optional) describe your variable"
  default = "172.28.0.0/16"
}