terraform {

  # cloud {
  #    organization = "Greatman"

  #   workspaces {
  #     name = "Terra-house-1"
  #   }
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
provider "aws" {

}
provider "random" {
  # Configuration options
}