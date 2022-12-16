output "aws_config_role_arn" {
  description = "The ARN of the AWS config role."
  value       = try(aws_iam_role.aws_config[0].arn, "")
}

output "aws_config_role_name" {
  description = "The name of the IAM role used by AWS config"
  value       = try(aws_iam_role.aws_config[0].name, "")
}