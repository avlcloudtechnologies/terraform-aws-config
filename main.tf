data "aws_caller_identity" "current" {}

############
# AWS Config
############

resource "aws_config_configuration_recorder" "this" {
  count = var.enable_aws_config ? 1 : 0

  name     = "${var.name}-config-recorder"
  role_arn = aws_iam_role.aws_config[0].arn

  recording_group {
    all_supported                 = var.resource_types == null ? true : false
    include_global_resource_types = var.resource_types == null ? var.include_global_resource_types : null
    resource_types                = var.resource_types == null ? null : var.resource_types
  }
}

resource "aws_config_delivery_channel" "this" {
  count = var.enable_aws_config ? 1 : 0

  name           = "${var.name}-config-channel"
  s3_bucket_name = var.aws_config_bucket_name
  s3_key_prefix  = var.aws_config_s3_key_prefix
  s3_kms_key_arn = var.aws_config_s3_kms_key_arn
  sns_topic_arn  = var.aws_config_sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.aws_config_delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  count = var.enable_aws_config ? 1 : 0

  name       = aws_config_configuration_recorder.this[0].name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.this]
}

#####
# IAM
#####

data "aws_iam_policy_document" "config_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "config_role_policy" {
  statement {
    sid    = "ConfigPutObject"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.aws_config_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}*"
    ]
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
  statement {
    sid    = "ConfigGetBucketAcl"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.aws_config_bucket_name}"
    ]
    actions = [
      "s3:GetBucketAcl"
    ]
  }
}

resource "aws_iam_role" "aws_config" {
  count = var.enable_aws_config ? 1 : 0

  name               = "${var.name}-config"
  assume_role_policy = data.aws_iam_policy_document.config_assume_role_policy.json
  tags               = var.iam_role_tags
}

resource "aws_iam_policy" "config_role_policy" {
  count = var.enable_aws_config ? 1 : 0

  name   = "${var.name}-config"
  policy = data.aws_iam_policy_document.config_role_policy.json
}

resource "aws_iam_role_policy_attachment" "config_role_policy" {
  count = var.enable_aws_config ? 1 : 0

  role       = aws_iam_role.aws_config[0].name
  policy_arn = aws_iam_policy.config_role_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  count = var.enable_aws_config ? 1 : 0

  role       = aws_iam_role.aws_config[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}