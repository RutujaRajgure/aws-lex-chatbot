provider "aws" {
 region = "ap-southeast-1"
}

resource "aws_s3_bucket" "lex_bucket" {
 bucket = "lex-chatbot-demo-bucket-12345"
}
