# main.tf

# Fetch available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block       = var.vpc_cidr_block
  availability_zones   = data.aws_availability_zones.available.names
}

# IAM Module
module "iam" {
  source = "./modules/iam"
}

# EKS Module
module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  eks_role_arn       = module.iam.eks_role_arn
  node_role_arn      = module.iam.node_role_arn
  node_role_name     = module.iam.node_role_name  # Add this line to pass the role name
  private_subnets    = module.vpc.private_subnets_ids
  node_instance_type = var.node_instance_type
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size
  max_size           = var.max_size

  # New parameters for EKS Addon
  ebs_csi_driver_addon_name = var.ebs_csi_driver_addon_name
  ebs_csi_driver_policy_arn = var.ebs_csi_driver_policy_arn
  resolve_conflicts         = var.resolve_conflicts
}
