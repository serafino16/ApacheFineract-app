cluster_config = {
  devstage = {
    cluster_name                        = "eks-devstage"
    cluster_service_ipv4_cidr           = "172.20.0.0/16"
    cluster_version                     = "1.21"
    cluster_endpoint_private_access     = false
    cluster_endpoint_public_access      = true
    cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
    eks_oidc_root_ca_thumbprint         = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  },
  prod = {
    cluster_name                        = "eks-prod"
    cluster_service_ipv4_cidr           = "172.30.0.0/16"
    cluster_version                     = "1.21"
    cluster_endpoint_private_access     = false
    cluster_endpoint_public_access      = true
    cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
    eks_oidc_root_ca_thumbprint         = "8f55b8c82989712bcba178f65d5b3e700ac82230"
  },
  prod_backup = {
    cluster_name                        = "eks-prod-backup"
    cluster_service_ipv4_cidr           = "172.40.0.0/16"
    cluster_version                     = "1.21"
    cluster_endpoint_private_access     = true
    cluster_endpoint_public_access      = false
    cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
    eks_oidc_root_ca_thumbprint         = "7b44a02c9a3159cbbd4c158276072ae18f11b122"
  }
}
