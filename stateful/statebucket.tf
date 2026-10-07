provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-s3-backend-horth"
    force_destroy = false

    lifecycle {
        prevent_destroy = true
    }
}

# enable versioning for S3 backend bucket
resource "aws_s3_bucket_versioning" "state_versioning" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

# Enable default encryption for s3 backend bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
    bucket = aws_s3_bucket.terraform_state.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Block public access for s3 backend bucket
resource "aws_s3_bucket_public_access_block" "state_public_block" {
    bucket = aws_s3_bucket.terraform_state.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}