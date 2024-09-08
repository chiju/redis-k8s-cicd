# variables.tf

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t2.small"
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 2
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ebs_csi_driver_addon_name" {
  description = "Name of the EKS addon for the CSI driver"
  type        = string
  default     = "aws-ebs-csi-driver"
}

variable "ebs_csi_driver_policy_arn" {
  description = "IAM policy ARN for the EBS CSI driver"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

variable "resolve_conflicts" {
  description = "Strategy to resolve conflicts for EKS addons"
  type        = string
  default     = "OVERWRITE"
}