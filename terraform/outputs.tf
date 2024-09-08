# outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets_ids
}

output "private_subnets_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets_ids
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_node_group_name" {
  description = "The name of the EKS node group"
  value       = module.eks.node_group_name
}

# Fetch the EKS cluster details
data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name  # Use the module output here
  depends_on = [module.eks]  # Ensure the EKS module runs first
}

data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_name  # Use the module output here
  depends_on = [module.eks]  # Ensure the EKS module runs first
}

output "kubeconfig" {
  value = aws_eks_cluster.main.kubeconfig[0]
  sensitive = true
}