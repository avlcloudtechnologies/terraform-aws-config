variable "enable_aws_config" {
  description = "Enables AWS Config"
  type        = bool
  default     = true
}

variable "name" {
  description = "Prefix to be used with resources"
  type        = string
}

variable "iam_role_tags" {
  description = "IAM role tags"
  type        = map(string)
  default     = {}
}

variable "aws_config_bucket_name" {
  description = "The name of the S3 bucket used to store the configuration history."
  type        = string
}

variable "aws_config_s3_key_prefix" {
  description = "The prefix for the specified S3 bucket."
  type        = string
  default     = null
}

variable "aws_config_s3_kms_key_arn" {
  description = "The ARN of the AWS KMS key used to encrypt objects delivered by AWS Config. Must belong to the same Region as the destination S3 bucket."
  type        = string
  default     = null
}

variable "aws_config_sns_topic_arn" {
  description = "The ARN of the SNS topic that AWS Config delivers notifications to."
  type        = string
  default     = null
}

variable "aws_config_delivery_frequency" {
  description = "The frequency with which AWS Config recurringly delivers configuration snapshotsE.g., One_Hour or Three_Hours.Valid values are listed here: https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigSnapshotDeliveryProperties.html#API_ConfigSnapshotDeliveryProperties_Contents."
  type        = string
  default     = "Six_Hours"
}

variable "resource_types" {
  description = "A list that specifies the types of AWS resources for which AWS Config records configuration changes (for example, AWS::EC2::Instance or AWS::CloudTrail::Trail)."
  type        = list(string)
  default     = null
}

variable "include_global_resource_types" {
  description = "Specifies whether AWS Config includes all supported types of global resources with the resources that it records."
  type        = bool
  default     = true
}