terraform {

  # cloud {
  #    organization = "Greatman"

  #   workspaces {
  #     name = "Terra-house-1"
  #   }
  # }

}

module "terrahouse_aws" {
  source      = "./modules/terrahouse_aws"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
}