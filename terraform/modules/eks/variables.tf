# modules/eks/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "eks_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
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

variable "node_role_name" {
  description = "IAM role name for the EKS worker nodes"
  type        = string
}