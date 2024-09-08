# modules/iam/outputs.tf

output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "node_role_name" {  # New output for the name
  value = aws_iam_role.node_role.name
}