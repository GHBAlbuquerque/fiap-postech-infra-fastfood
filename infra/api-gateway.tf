resource "aws_api_gateway_rest_api" "api_gateway_fiap_postech" {
  name        = var.project_name
  description = "created with terraform"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_fiap_postech.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

#resource "aws_api_gateway_integration" "lambda" {
#  rest_api_id = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
#  resource_id = aws_api_gateway_method.proxy.resource_id
#  http_method = aws_api_gateway_method.proxy.http_method
#
#  integration_http_method = "POST"
#  type                    = "AWS_PROXY"
#  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}:$${stageVariables.stage}/invocations"
#} //TODO

#resource "aws_api_gateway_deployment" "deployment_dev" {
#  depends_on = [
#    aws_api_gateway_integration.lambda
#  ]
#
#  rest_api_id = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
#}


#resource "aws_api_gateway_stage" "dev" {
#  deployment_id = aws_api_gateway_deployment.deployment_dev.id
#  rest_api_id   = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
#  stage_name    = "dev"
#
#  variables = {
#    "stage" = "dev"
#  }
#}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
}

#output "dev_env" {
#  value = "${aws_api_gateway_stage.dev.invoke_url}/hello"
#}

resource "aws_api_gateway_authorizer" "lambda_authorizer_cpf" {
  name                   = "lambda_authorizer_cognito"
  rest_api_id            = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
  authorizer_uri         = "arn:aws:apigateway:${var.region}:lambda:path/2024-04-22/functions/${var.lambda_arn}/invocations"
  authorizer_credentials = var.lab_role_arn
  type                   = "REQUEST"
  identity_source        = "method.request.header.cpf_cliente"
}


resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.api_gateway_fiap_postech.execution_arn}/*/*"
}
