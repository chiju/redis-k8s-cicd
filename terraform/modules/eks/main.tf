# modules/eks/main.tf

# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.private_subnets
  }
}

# EKS Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = [var.node_instance_type]

}

# IAM Role Policy Attachment for EBS CSI Driver
resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = var.node_role_name  # Use the role name here
}

# Addon Version Data Source for aws-ebs-csi-driver
data "aws_eks_addon_version" "ebs_csi_driver" {
  addon_name         = var.ebs_csi_driver_addon_name
  kubernetes_version = aws_eks_cluster.main.version
  most_recent        = true
}

# EKS Addon for aws-ebs-csi-driver
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = var.ebs_csi_driver_addon_name

  addon_version               = data.aws_eks_addon_version.ebs_csi_driver.version
  configuration_values        = null
  preserve                    = true
  resolve_conflicts_on_create = var.resolve_conflicts
  resolve_conflicts_on_update = var.resolve_conflicts
  service_account_role_arn    = null

  depends_on = [
    aws_eks_node_group.main,
    aws_iam_role_policy_attachment.ebs_csi_driver  # Ensure this is created before the addon
  ]
}

