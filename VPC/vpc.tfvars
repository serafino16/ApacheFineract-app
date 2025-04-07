

vpc_cidr_block = {
  "eu-west-3" = "10.0.0.0/16"
  "eu-west-2" = "10.1.0.0/16"
  "eu-west-1" = "10.2.0.0/16"
}


vpc_availability_zones = {
  "eu-west-3" = ["eu-west-3a", "eu-west-3b"]
  "eu-west-2" = ["eu-west-2a", "eu-west-2b"]
  "eu-west-1" = ["eu-west-1a", "eu-west-1b"]
}


vpc_public_subnets = {
  "eu-west-3" = ["10.0.1.0/24", "10.0.2.0/24"]
  "eu-west-2" = ["10.1.1.0/24", "10.1.2.0/24"]
  "eu-west-1" = ["10.2.1.0/24", "10.2.2.0/24"]
}


vpc_private_subnets = {
  "eu-west-3" = ["10.0.3.0/24", "10.0.4.0/24"]
  "eu-west-2" = ["10.1.3.0/24", "10.1.4.0/24"]
  "eu-west-1" = ["10.2.3.0/24", "10.2.4.0/24"]
}


vpc_database_subnets = {
  "eu-west-3" = ["10.0.5.0/24"]
  "eu-west-2" = ["10.1.5.0/24"]
  "eu-west-1" = ["10.2.5.0/24"]
}


vpc_create_database_subnet_group = {
  "eu-west-3" = true
  "eu-west-2" = true
  "eu-west-1" = true
}


vpc_create_database_subnet_route_table = {
  "eu-west-2" = true
  "eu-west-3" = true
  "eu-west-1" = true
}


vpc_enable_nat_gateway = {
  "eu-west-3" = true
  "eu-west-2" = true
  "eu-west-1" = true
}


