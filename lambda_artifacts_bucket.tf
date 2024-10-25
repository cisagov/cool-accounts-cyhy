# This bucket is used to store the deployment packages for any Lambda functions
# that will be used in a CyHy environment.
resource "aws_s3_bucket" "lambda_artifacts" {
  bucket_prefix = var.cyhy_lambda_artifacts_s3_bucket_prefix

  tags = {
    "Name" = "Lambda Deployment Artifacts"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Ensure the S3 bucket is encrypted
resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# This blocks ANY public access to the bucket or the objects it
# contains, even if misconfigured to allow public access.
resource "aws_s3_bucket_public_access_block" "lambda_artifacts" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.lambda_artifacts.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Any objects placed into this bucket should be owned by the bucket
# owner. This ensures that even if objects are added by a different
# account, the bucket-owning account retains full control over the
# objects stored in this bucket.
resource "aws_s3_bucket_ownership_controls" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Enable versioning on the bucket.  This allows Terraform to determine when a
# new version of the Lambda deployment package is uploaded and update the Lambda
# function accordingly.
resource "aws_s3_bucket_versioning" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}
