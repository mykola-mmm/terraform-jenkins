variable "vpc_cidr" {
  description = "public vpc cidr block"
  type        = string
}

variable "vpc_name" {
  description = "public subnet Name"
  type        = string
}

variable "cidr_public_subnet" {
  description = "public subnet cidr blocks"
  type        = list(string)
}

variable "cidr_private_subnet" {
  description = "private subnet cidr blocks"
  type        = list(string)
}

variable "availability_zone" {
  description = "availability zones"
  type        = list(string)
}