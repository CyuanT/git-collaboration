module "sns" {
  source = "terraform-aws-modules/sns/aws"
  # version = ">= 5.0"

  name = "ty-gitact-terra-sns"

  topic_policy_statements = {
    sqs = {
      sid     = var.sns_policy_statment.sid
      actions = var.sns_policy_statment.actions

      principals = var.sns_policy_statment.principals

      conditions = merge(var.sns_policy_statment.conditions, { values = "${module.sqs.queue_arn}" })
    }
  }

  subscriptions = {
    sqs = {
      protocol = "sqs"
      endpoint = module.sqs.queue_arn
    }
  }

  tags = {
    Creator = "group3"
  }
}

module "sqs" {
  source = "terraform-aws-modules/sqs/aws"

  name = "ty-gitact-terra-sqs"

  create_queue_policy = true
  queue_policy_statements = {
    sns = {
      sid     = "SNSPublish"
      actions = ["sqs:SendMessage"]

      principals = [
        {
          type        = "Service"
          identifiers = ["sns.amazonaws.com"]
        }
      ]

      conditions = [{
        test     = "ArnEquals"
        variable = "aws:SourceArn"
        values   = [module.sns.topic_arn]
      }]
    }
  }

  tags = {
    Creator = "group3"
  }
}