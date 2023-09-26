terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
<<<<<<< HEAD
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
=======
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 16
  special          = false
 
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}


>>>>>>> main

provider "random" {
  # Configuration options
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length = 32
  special = false
 
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

 #tags = {
 #   Name        = "My bucket"
 #   Environment = "Dev"
  }
#}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}
