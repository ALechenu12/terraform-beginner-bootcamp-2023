
#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    User_uuid = var.user_uuid

  }
}

