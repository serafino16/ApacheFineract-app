resource "aws_vpc" "devstage" {
  provider             = aws.devstage
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_vpc" "prod" {
  provider             = aws.prod
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_vpc" "prod_backup" {
  provider             = aws.prod_backup
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_ec2_transit_gateway" "tgw" {
  description = "Multi-region Transit Gateway"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "devstage_tgw_attachment" {
  provider           = aws.devstage
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id            = aws_vpc.devstage.id
  subnet_ids        = aws_subnet.devstage[*].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "prod_tgw_attachment" {
  provider           = aws.prod
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id            = aws_vpc.prod.id
  subnet_ids        = aws_subnet.prod[*].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "prod_backup_tgw_attachment" {
  provider           = aws.prod_backup
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id            = aws_vpc.prod_backup.id
  subnet_ids        = aws_subnet.prod_backup[*].id
}

resource "aws_route_table" "devstage_route" {
  provider   = aws.devstage
  vpc_id     = aws_vpc.devstage.id
}

resource "aws_route" "devstage_tgw_route" {
  provider           = aws.devstage
  route_table_id     = aws_route_table.devstage_route.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route_table" "prod_route" {
  provider   = aws.prod
  vpc_id     = aws_vpc.prod.id
}

resource "aws_route" "prod_tgw_route" {
  provider           = aws.prod
  route_table_id     = aws_route_table.prod_route.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route_table" "prod_backup_route" {
  provider   = aws.prod_backup
  vpc_id     = aws_vpc.prod_backup.id
}

resource "aws_route" "prod_backup_tgw_route" {
  provider           = aws.prod_backup
  route_table_id     = aws_route_table.prod_backup_route.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}
resource "aws_vpc" "vpc_multi_region" {
  for_each = toset(["eu-west-3", "eu-west-2", "eu-west-1"]) 

  provider = aws.${each.key} 

  name = "${local.name}-${var.vpc_name}-${each.key}"
  cidr = var.vpc_cidr_block[each.key] 
  azs = var.vpc_availability_zones[each.key] 
  public_subnets = var.vpc_public_subnets[each.key] 
  private_subnets = var.vpc_private_subnets[each.key] 

  database_subnets = var.vpc_database_subnets[each.key] 
  create_database_subnet_group = var.vpc_create_database_subnet_group[each.key] 
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table[each.key] 
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route = true

  enable_nat_gateway = var.vpc_enable_nat_gateway[each.key] 
  
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, { "Region" = each.key })
  vpc_tags = local.common_tags

  public_subnet_tags = merge(local.common_tags, {
    Type = "Public Subnets"
  })
  private_subnet_tags = merge(local.common_tags, {
    Type = "Private Subnets"
  })
  database_subnet_tags = merge(local.common_tags, {
    Type = "Private Database Subnets"
  })

  map_public_ip_on_launch = true
}
