module "networking" {
  source              = "./networking"
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  cidr_public_subnet  = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  availability_zone  = var.availability_zone
}