
locals {
  common_tags = {
    "Environment" = "production"
    "Project"     = "MultiRegionVPC"
    "Owner"       = "YourName"
    "CostCenter"  = "IT"
  }
}


locals {
  name = "my-vpc"
}


locals {
  vpc_cidr_block = {
    "eu-west-3" = "10.0.0.0/16"
    "eu-west-2" = "10.1.0.0/16"
    "eu-west-1" = "10.2.0.0/16"
  }
}


locals {
  vpc_availability_zones = {
    "eu-west-2" = ["eu-west-2a", "eu-west-2b"]
    "us-west-1" = ["eu-west-1a", "eu-west-1b"]
    "eu-west-3" = ["eu-west-3a", "eu-west-3b"]
  }
}


locals {
  vpc_public_subnets = {
    "eu-west-2" = ["10.0.1.0/24", "10.0.2.0/24"]
    "eu-west-3" = ["10.1.1.0/24", "10.1.2.0/24"]
    "eu-west-1" = ["10.2.1.0/24", "10.2.2.0/24"]
  }
}


locals {
  vpc_private_subnets = {
    "eu-west-3" = ["10.0.3.0/24", "10.0.4.0/24"]
    "eu-west-2" = ["10.1.3.0/24", "10.1.4.0/24"]
    "eu-west-1" = ["10.2.3.0/24", "10.2.4.0/24"]
  }
}


locals {
  vpc_database_subnets = {
    "eu-west-3" = ["10.0.5.0/24"]
    "eu-west-2" = ["10.1.5.0/24"]
    "eu-west-1" = ["10.2.5.0/24"]
  }
}


locals {
  vpc_create_database_subnet_group = {
    "eu-west-3" = true
    "eu-west-2" = true
    "eu-west-1" = true
  }

  vpc_create_database_subnet_route_table = {
    "eu-west-3" = true
    "eu-west-2" = true
    "eu-west-1" = true
  }

  vpc_enable_nat_gateway = {
    "eu-west-3" = true
    "eu-west-2" = true
    "eu-west-1" = true
  }
}


locals {
  public_subnet_tags = merge(local.common_tags, {
    "Type" = "Public Subnets"
  })

  private_subnet_tags = merge(local.common_tags, {
    "Type" = "Private Subnets"
  })

  database_subnet_tags = merge(local.common_tags, {
    "Type" = "Private Database Subnets"
  })
}


locals {
  vpc_name = {
    for region in keys(local.vpc_cidr_block) : region => "${local.name}-${region}"
  }
}

