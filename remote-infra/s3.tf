resource "aws_s3_bucket" "remote_s3" {
  bucket = "ayush-ki-bucket"

  tags = {
    Name        = "ayush-ki-bucket"
  
  }
}