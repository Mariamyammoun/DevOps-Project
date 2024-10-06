terraform {
  backend "s3" {
    bucket = "mariam-bucket"
    key = "server_name/statefile"
    region = "eu-north-1"
  }
}  
