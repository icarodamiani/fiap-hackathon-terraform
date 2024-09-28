resource "aws_sqs_queue" "documentos_emitir_queue" {
  name                       = "documentos_emitir_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "documentos_emitir_dlq_queue" {
  name                       = "documentos_emitir_dlq_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "veiculos_update_queue" {
  name                       = "veiculos_update_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "veiculos_update_dlq_queue" {
  name                       = "veiculos_update_dlq_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "pessoa_data_cleanup_queue" {
  name                       = "pessoa_data_cleanup_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "pessoa_data_cleanup_dlq_queue" {
  name                       = "pessoa_data_cleanup_dlq_queue"
  delay_seconds              = 10
  visibility_timeout_seconds = 30
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled = true
}

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    sid    = "docemitirpd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.documentos_emitir_queue.arn
    ]
  }
  statement {
    sid    = "docemitirdlqpd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.documentos_emitir_dlq_queue.arn
    ]
  }
  statement {
    sid    = "pcleanpd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.pessoa_data_cleanup_queue.arn
    ]
  }
  statement {
    sid    = "pcleandlqpd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.pessoa_data_cleanup_dlq_queue.arn
    ]
  }
  statement {
    sid    = "vupdatepd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.veiculos_update_queue.arn
    ]
  }
  statement {
    sid    = "vupdatedlqpd"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.veiculos_update_dlq_queue.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "doc_emitir_policy" {
  queue_url = aws_sqs_queue.documentos_emitir_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_sqs_queue_policy" "doc_emitir_dlq_policy" {
  queue_url = aws_sqs_queue.documentos_emitir_dlq_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_sqs_queue_policy" "veic_upt_policy" {
  queue_url = aws_sqs_queue.veiculos_update_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_sqs_queue_policy" "veic_upt_dlq_policy" {
  queue_url = aws_sqs_queue.veiculos_update_dlq_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_sqs_queue_policy" "pes_clean_policy" {
  queue_url = aws_sqs_queue.pessoa_data_cleanup_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}

resource "aws_sqs_queue_policy" "pes_clean_dlq_policy" {
  queue_url = aws_sqs_queue.pessoa_data_cleanup_dlq_queue.id
  policy    = data.aws_iam_policy_document.sqs_policy.json
}