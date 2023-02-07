resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-backend-958021034198"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_table" {
  
  name         = "Table-958021034198"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-ali-958021034198"
    key    = "terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "Table-958021034198"
    encrypt = true
  }
}