# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows provisioning of
# the resources required by cisagov/cyhy-tf-root.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisioncyhyroot_policy_attachment" {
  policy_arn = aws_iam_policy.provisioncyhyroot_policy.arn
  role       = var.provisionaccount_role_name
}
