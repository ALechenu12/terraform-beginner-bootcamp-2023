variable "user_uuid" {
  description = "User UUID"
  type        = string
}

variable "bucket_name" {
  description = "The AWS S3 bucket name"
  type        = string
}

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

}

variable "content_version" {
  description = "Content version (positive integer starting at 1)"
  type        = number
}

variable "assets_path" {
  description = "Path to assts folder"
  type = string
  
}