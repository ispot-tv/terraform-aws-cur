resource "aws_cur_report_definition" "this" {
  count       = var.existing_cur_report != null ? 0 : 1
  report_name                = var.report_name
  time_unit                  = var.report_frequency
  format                     = var.report_format
  compression                = var.report_compression
  report_versioning          = var.report_versioning
  additional_artifacts       = var.report_additional_artifacts
  additional_schema_elements = ["RESOURCES"]

  s3_bucket = var.s3_bucket_name
  s3_region = var.use_existing_s3_bucket ? data.aws_s3_bucket.cur[0].region : aws_s3_bucket.cur[0].region
  s3_prefix = var.s3_bucket_prefix

  depends_on = [
    aws_s3_bucket_policy.cur,
  ]

  provider = aws.cur
}

data "aws_cur_report_definition" "existing_cur_report" {
  count       = var.existing_cur_report != null ? 1 : 0
  report_name = var.existing_cur_report
}
