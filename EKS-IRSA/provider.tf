
provider "aws" {
  alias  = "prod"
  region = "us-east-1"
}

provider "aws" {
  alias  = "prodbackup"
  region = "eu-west-2"
}
provider "aws" {
  alias  = "devstage"
  region = "eu-west-3"
}
provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.cluster_endpoint 
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}