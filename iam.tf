data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "default" {
  count = var.kms_key_id != null ? 1 : 0

  statement {
    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey",
    ]
    resources = ["arn:aws:kms:*:*:key/${var.kms_key_id}"]
  }
}

resource "aws_iam_role" "default" {
  count = var.role_arn == null ? 1 : 0

  name               = "SageMakerExecutionRole-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "default" {
  count = var.role_arn == null && var.kms_key_id != null ? 1 : 0

  name   = "SageMakerExecutionRole-${var.name}"
  role   = aws_iam_role.default[0].id
  policy = data.aws_iam_policy_document.default[0].json
}

resource "aws_iam_role_policy_attachment" "default" {
  count = var.role_arn == null ? 1 : 0

  role       = aws_iam_role.default[0].id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}
