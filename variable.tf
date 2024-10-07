variable "lambda_function_name" {
  description = "Name of lambda function"
  type        = string
  default     = "group3-lambda-new"
}

variable "lambda_file_name" {
  description = "Name of lambda file to be zipped"
  type        = string
  default     = "lambda_function"
}

variable "bucket_region" {
  description = "Region for S3 Bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Region for S3 Bucket"
  type        = string
  default     = "group3-tf-s3"
}

variable "sns_policy_statment" {
  description = "sns_policy_configuration"
  type = object({
    sid     = string,
    actions = list(string),
    principals = object({
      type        = string
      identifiers = list
    }),
    conditions = object({
      test     = string
      variable = string
    })
  })

  default = {
    sid     = "SQSSubscribe",
    actions = ["sns:Subscribe", "sns:Receive"],
    principals = [{
      type        = "AWS"
      identifiers = ["*"]
    }],
    conditions = [{
      test     = "StringLike"
      variable = "sns:Endpoint"
    }]
  }
}

# variable "vpc_id" {
#   description = "Virtural Private Cloud ID"
#   type        = string
#   default     = "vpc-033addf3a46d7960e" # to replace
# }

variable "ec2_instance_type" {
  description = "ect instance type"
  type        = string
  default     = "t2.micro" # to replace
}