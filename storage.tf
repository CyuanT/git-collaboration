resource "aws_s3_bucket" "s3_group3" {
  bucket = "${var.bucket_region}-${var.bucket_name}"

  tags = {
    Name = "Owned by ${var.bucket_name}"
  }
}