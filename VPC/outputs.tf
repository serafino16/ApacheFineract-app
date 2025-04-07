
output "vpc_ids" {
  description = "VPC IDs per region"
  value = {
    for region, vpc in aws_vpc.vpc_multi_region : region => vpc.id
  }
}


output "public_subnet_ids" {
  description = "Public Subnet IDs per region"
  value = {
    for region, vpc in aws_vpc.vpc_multi_region : region => vpc.public_subnets
  }
}


output "private_subnet_ids" {
  description = "Private Subnet IDs per region"
  value = {
    for region, vpc in aws_vpc.vpc_multi_region : region => vpc.private_subnets
  }
}


output "database_subnet_ids" {
  description = "Database Subnet IDs per region"
  value = {
    for region, vpc in aws_vpc.vpc_multi_region : region => vpc.database_subnets
  }
}


output "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  value = aws_ec2_transit_gateway.tgw.id
}


output "transit_gateway_attachments" {
  description = "Transit Gateway Attachments per VPC"
  value = {
    "devstage"         = aws_ec2_transit_gateway_vpc_attachment.devstage_tgw_attachment.id
    "prod"             = aws_ec2_transit_gateway_vpc_attachment.prod_tgw_attachment.id
    "prod_backup"      = aws_ec2_transit_gateway_vpc_attachment.prod_backup_tgw_attachment.id
  }
}


output "route_table_ids" {
  description = "Route Table IDs per region"
  value = {
    "devstage"        = aws_route_table.devstage_route.id
    "prod"            = aws_route_table.prod_route.id
    "prod_backup"     = aws_route_table.prod_backup_route.id
  }
}


output "routes_to_tgw" {
  description = "Routes to Transit Gateway per region"
  value = {
    "devstage"        = aws_route.devstage_tgw_route.id
    "prod"            = aws_route.prod_tgw_route.id
    "prod_backup"     = aws_route.prod_backup_tgw_route.id
  }
}



