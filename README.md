# AWS Config Terraform module
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/avlcloudtechnologies/terraform-aws-config)

This module handles creation of AWS Config resources.

## Usage


```hcl
module "aws_config" {
  source = "git::https://github.com/avlcloudtechnologies/terraform-aws-config.git?ref=v0.1.0

  enable_aws_config      = false
  name                   = "my_prefix"
  aws_config_bucket_name = "my_aws_config_s3_bucket"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_config_configuration_recorder.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_policy.config_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.config_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.config_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.config_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_config_bucket_name"></a> [aws\_config\_bucket\_name](#input\_aws\_config\_bucket\_name) | The name of the S3 bucket used to store the configuration history. | `string` | n/a | yes |
| <a name="input_aws_config_delivery_frequency"></a> [aws\_config\_delivery\_frequency](#input\_aws\_config\_delivery\_frequency) | The frequency with which AWS Config recurringly delivers configuration snapshotsE.g., One\_Hour or Three\_Hours.Valid values are listed here: https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigSnapshotDeliveryProperties.html#API_ConfigSnapshotDeliveryProperties_Contents. | `string` | `"Six_Hours"` | no |
| <a name="input_aws_config_s3_key_prefix"></a> [aws\_config\_s3\_key\_prefix](#input\_aws\_config\_s3\_key\_prefix) | The prefix for the specified S3 bucket. | `string` | `null` | no |
| <a name="input_aws_config_s3_kms_key_arn"></a> [aws\_config\_s3\_kms\_key\_arn](#input\_aws\_config\_s3\_kms\_key\_arn) | The ARN of the AWS KMS key used to encrypt objects delivered by AWS Config. Must belong to the same Region as the destination S3 bucket. | `string` | `null` | no |
| <a name="input_aws_config_sns_topic_arn"></a> [aws\_config\_sns\_topic\_arn](#input\_aws\_config\_sns\_topic\_arn) | The ARN of the SNS topic that AWS Config delivers notifications to. | `string` | `null` | no |
| <a name="input_enable_aws_config"></a> [enable\_aws\_config](#input\_enable\_aws\_config) | Enables AWS Config | `bool` | `true` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | IAM role tags | `map(string)` | `{}` | no |
| <a name="input_include_global_resource_types"></a> [include\_global\_resource\_types](#input\_include\_global\_resource\_types) | Specifies whether AWS Config includes all supported types of global resources with the resources that it records. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Prefix to be used with resources | `string` | n/a | yes |
| <a name="input_resource_types"></a> [resource\_types](#input\_resource\_types) | A list that specifies the types of AWS resources for which AWS Config records configuration changes (for example, AWS::EC2::Instance or AWS::CloudTrail::Trail). | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_config_role_arn"></a> [aws\_config\_role\_arn](#output\_aws\_config\_role\_arn) | The ARN of the AWS config role. |
| <a name="output_aws_config_role_name"></a> [aws\_config\_role\_name](#output\_aws\_config\_role\_name) | The name of the IAM role used by AWS config |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->