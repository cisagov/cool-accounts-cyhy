# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary to
# provision the Lambda deployment artifacts bucket.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionlambdabucket_policy_doc" {
  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:Get*",
      "s3:ListBucket",
      "s3:PutBucketOwnershipControls",
      "s3:PutBucketPolicy",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:TagResource",
    ]

    resources = [
      "arn:aws:s3:::${var.cyhy_lambda_artifacts_s3_bucket_prefix}*",
    ]
  }
}

resource "aws_iam_policy" "provisionlambdabucket_policy" {
  description = var.provisionlambdabucket_policy_description
  name        = var.provisionlambdabucket_policy_name
  policy      = data.aws_iam_policy_document.provisionlambdabucket_policy_doc.json
}
