output "bucket_name" {
  description = "Bucket name for our static website"
  value = module.terrahouse_aws.bucket_name
}


output "s3website_endpoint" {
  description = "S3 static website hoosting endpoint"
  value = module.terrahouse_aws.website_endpoint
}