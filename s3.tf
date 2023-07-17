resource "aws_s3_bucket" "cp_b00_s3_bucket" {
  bucket = "cp-b00-s3-bucket"

  tags = {
    Name        = "cp-b00-s3-bucket"
    Environment = "Demo"
  }
}
