resource "aws_api_gateway_rest_api" "api_gateway_fiap_postech" {
  name        = "api_gateway_fiap_postech"
  description = "Projeto de um sistema para lanchonete realizado para a Pós-Graduação de Arquitetura de Sistemas da FIAP"

  body = jsonencode(file("../config/api_definition.json"))

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "postech_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_fiap_postech.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway_fiap_postech.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "postech_stage_test" {
  deployment_id = aws_api_gateway_deployment.postech_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
  stage_name    = "postech_stage_test"
}


output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
}

