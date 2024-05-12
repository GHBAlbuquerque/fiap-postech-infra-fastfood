locals {
  load_balancer_dns    = aws_alb.alb-cluster-fiap.dns_name
  lambda_authorize_uri = "arn:aws:apigateway:${var.region}:lambda:path/2024-04-22/functions/${var.lambda_arn}/invocations"
}

data "template_file" "api_template" {
  # FIXME: uso de template_file nao funcionou -> invalid OpenAPI Specification
  template = file("../config/api_definition.json.tpl")
  vars     = {
    load_balancer_dns = "http://${local.load_balancer_dns}"
    accountid         = var.accountid
    region            = var.region
    lambda_arn        = var.lambda_arn
  }
}

resource "aws_api_gateway_rest_api" "api_gateway_fiap_postech" {
  depends_on  = [aws_alb.alb-cluster-fiap]
  name        = "api_gateway_fiap_postech"
  description = "Projeto de um sistema para lanchonete realizado para a Pós-Graduação de Arquitetura de Sistemas da FIAP"

  # body = jsonencode(data.template_file.api_template) # FIXME: esta config usando template_file nao funcionou.
  body = jsonencode(
    {
      "openapi" : "3.0.1",
      "info" : {
        "title" : "Fast Food FIAP",
        "description" : "Projeto de um sistema para lanchonete realizado para a Pós-Graduação de Arquitetura de Sistemas da FIAP",
        "version" : "v1"
      },
      "servers" : [
        {
          "url" : "http://${local.load_balancer_dns}",
          "description" : "Generated server url"
        }
      ],
      "paths" : {
        "/" : {
          "get" : {
            "operationId" : "Get",
            "responses" : {
              "200" : {
                "description" : "200 response",
                "headers" : {
                  "Access-Control-Allow-Origin" : {
                    "schema" : {
                      "type" : "string"
                    }
                  }
                },
                "content" : {}
              }
            },
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "uri" : "http://${local.load_balancer_dns}/",
              "responses" : {
                "default" : {
                  "statusCode" : "200",
                  "responseParameters" : {
                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                  }
                }
              },
              "passthroughBehavior" : "when_no_match",
              "type" : "http"
            }
          },
          "options" : {
            "responses" : {
              "200" : {
                "description" : "200 response",
                "headers" : {
                  "Access-Control-Allow-Origin" : {
                    "schema" : {
                      "type" : "string"
                    }
                  },
                  "Access-Control-Allow-Methods" : {
                    "schema" : {
                      "type" : "string"
                    }
                  },
                  "Access-Control-Allow-Headers" : {
                    "schema" : {
                      "type" : "string"
                    }
                  }
                },
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/Empty"
                    }
                  }
                }
              }
            },
            "x-amazon-apigateway-integration" : {
              "responses" : {
                "default" : {
                  "statusCode" : "200",
                  "responseParameters" : {
                    "method.response.header.Access-Control-Allow-Methods" : "'GET,OPTIONS'",
                    "method.response.header.Access-Control-Allow-Headers" : "'Content-Type,X-Amz-Date,Authorization,X-Api-Key'",
                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                  }
                }
              },
              "requestTemplates" : {
                "application/json" : "{\"statusCode\": 200}"
              },
              "passthroughBehavior" : "when_no_match",
              "type" : "mock"
            }
          }
        },
        "/actuator/health" : {
          "get" : {
            "operationId" : "Get",
            "responses" : {
              "200" : {
                "description" : "200 response",
                "headers" : {
                  "Access-Control-Allow-Origin" : {
                    "schema" : {
                      "type" : "string"
                    }
                  }
                },
                "content" : {}
              }
            },
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "uri" : "http://${local.load_balancer_dns}/actuator/health",
              "responses" : {
                "default" : {
                  "statusCode" : "200",
                  "responseParameters" : {
                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                  }
                }
              },
              "passthroughBehavior" : "when_no_match",
              "type" : "http"
            }
          }
        },
        "/swagger-ui/index" : {
          "get" : {
            "operationId" : "Get",
            "responses" : {
              "200" : {
                "description" : "200 response",
                "headers" : {
                  "Access-Control-Allow-Origin" : {
                    "schema" : {
                      "type" : "string"
                    }
                  }
                },
                "content" : {}
              }
            },
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "uri" : "http://${local.load_balancer_dns}/swagger-ui/index.html",
              "responses" : {
                "default" : {
                  "statusCode" : "200",
                  "responseParameters" : {
                    "method.response.header.Access-Control-Allow-Origin" : "'*'"
                  }
                }
              },
              "passthroughBehavior" : "when_no_match",
              "type" : "http"
            }
          }
        },
        "/products/{id}" : {
          "put" : {
            "tags" : [
              "product-controller"
            ],
            "operationId" : "updateProduct",
            "parameters" : [
              {
                "name" : "id",
                "in" : "path",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "requestBody" : {
              "content" : {
                "application/json" : {
                  "schema" : {
                    "$ref" : "#/components/schemas/UpdateProductRequest"
                  }
                }
              },
              "required" : true
            },
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/BaseProductResponse"
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "PUT",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/products/{id}"
            }
          },
          "delete" : {
            "tags" : [
              "product-controller"
            ],
            "operationId" : "deleteProduct",
            "parameters" : [
              {
                "name" : "id",
                "in" : "path",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success"
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "DELETE",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/products/{id}"
            }
          }
        },
        "/products" : {
          "get" : {
            "tags" : [
              "product-controller"
            ],
            "operationId" : "findProduct",
            "parameters" : [
              {
                "name" : "category",
                "in" : "query",
                "required" : true,
                "schema" : {
                  "type" : "string",
                  "enum" : [
                    "SANDWICH",
                    "SIDE_DISH",
                    "DRINK"
                  ]
                }
              },
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "type" : "array",
                      "items" : {
                        "$ref" : "#/components/schemas/BaseProductResponse"
                      }
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/products"
            }
          },
          "post" : {
            "tags" : [
              "product-controller"
            ],
            "operationId" : "createProduct",
            "requestBody" : {
              "content" : {
                "application/json" : {
                  "schema" : {
                    "$ref" : "#/components/schemas/CreateProductRequest"
                  }
                }
              },
              "required" : true
            },
            "parameters" : [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/BaseProductResponse"
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "POST",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/products"
            }
          }
        },
        "/orders" : {
          "get" : {
            "tags" : [
              "order-controller"
            ],
            "operationId" : "getOrders",
            "parameters": [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "type" : "array",
                      "items" : {
                        "$ref" : "#/components/schemas/GetOrderResponse"
                      }
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/orders"
            }
          },
          "post" : {
            "tags" : [
              "order-controller"
            ],
            "operationId" : "createOrder",
            "requestBody" : {
              "content" : {
                "application/json" : {
                  "schema" : {
                    "$ref" : "#/components/schemas/CreateOrderRequest"
                  }
                }
              },
              "required" : true
            },
            "parameters": [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success"
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "POST",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/orders"
            }
          }
        },
        "/clients" : {
          "get" : {
            "tags" : [
              "client-controller"
            ],
            "operationId" : "getClientByCpf",
            "parameters" : [
              {
                "name" : "cpf",
                "in" : "query",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/GetClientResponse"
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/clients"
            }
          },
          "post" : {
            "tags" : [
              "client-controller"
            ],
            "operationId" : "registerClient",
            "requestBody" : {
              "content" : {
                "application/json" : {
                  "schema" : {
                    "$ref" : "#/components/schemas/RegisterClientRequest"
                  }
                }
              },
              "required" : true
            },
            "parameters": [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/RegisterClientResponse"
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "POST",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/clients"
            }
          }
        },
        "/checkout" : {
          "get" : {
            "tags" : [
              "checkout-controller"
            ],
            "operationId" : "findAll",
            "parameters": [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "type" : "array",
                      "items" : {
                        "$ref" : "#/components/schemas/CheckoutResponse"
                      }
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/checkout"
            }
          },
          "post" : {
            "tags" : [
              "checkout-controller"
            ],
            "operationId" : "checkout",
            "requestBody" : {
              "content" : {
                "application/json" : {
                  "schema" : {
                    "$ref" : "#/components/schemas/CheckoutRequest"
                  }
                }
              },
              "required" : true
            },
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success"
              }
            },
            "parameters": [
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "POST",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/checkout"
            }
          }
        },
        "/orders/{orderId}/payment-status" : {
          "get" : {
            "tags" : [
              "order-controller"
            ],
            "operationId" : "getOrderPaymentStatus",
            "parameters" : [
              {
                "name" : "orderId",
                "in" : "path",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "cpf_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              },
              {
                "name" : "senha_cliente",
                "in" : "header",
                "required" : true,
                "schema" : {
                  "type" : "string"
                }
              }
            ],
            "responses" : {
              "400" : {
                "description" : "Bad Request",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "403" : {
                "description" : "Forbidden",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "404" : {
                "description" : "Not Found",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "500" : {
                "description" : "Internal Server Error",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/ExceptionDetails"
                    }
                  }
                }
              },
              "200" : {
                "description" : "Success",
                "content" : {
                  "application/json" : {
                    "schema" : {
                      "$ref" : "#/components/schemas/GetOrderPaymentStatusResponse"
                    }
                  }
                }
              }
            },
            "security" : [{ "lambda_authorizer_cpf" : [] }],
            "x-amazon-apigateway-integration" : {
              "httpMethod" : "GET",
              "payloadFormatVersion" : "1.0",
              "type" : "HTTP_PROXY",
              "uri" : "http://${local.load_balancer_dns}/payment-status"
            }
          }
        }
      },
      "components" : {
        "schemas" : {
          "UpdateProductRequest" : {
            "required" : [
              "description",
              "name",
              "price",
              "type"
            ],
            "type" : "object",
            "properties" : {
              "name" : {
                "maxLength" : 2147483647,
                "minLength" : 3,
                "type" : "string"
              },
              "price" : {
                "type" : "number"
              },
              "description" : {
                "type" : "string"
              },
              "type" : {
                "type" : "string"
              }
            }
          },
          "CustomError" : {
            "type" : "object",
            "properties" : {
              "message" : {
                "type" : "string"
              },
              "field" : {
                "type" : "string"
              },
              "attemptedValue" : {
                "type" : "object"
              }
            }
          },
          "ExceptionDetails" : {
            "type" : "object",
            "properties" : {
              "type" : {
                "type" : "string"
              },
              "title" : {
                "type" : "string"
              },
              "code" : {
                "type" : "string"
              },
              "detail" : {
                "type" : "string"
              },
              "status" : {
                "type" : "integer",
                "format" : "int32"
              },
              "date" : {
                "type" : "string",
                "format" : "date-time"
              },
              "errors" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/CustomError"
                }
              }
            }
          },
          "BaseProductResponse" : {
            "type" : "object",
            "properties" : {
              "name" : {
                "type" : "string"
              },
              "price" : {
                "type" : "number"
              },
              "description" : {
                "type" : "string"
              },
              "type" : {
                "type" : "string"
              },
              "createdAt" : {
                "type" : "string",
                "format" : "date-time"
              },
              "updatedAt" : {
                "type" : "string",
                "format" : "date-time"
              }
            }
          },
          "CreateProductRequest" : {
            "required" : [
              "description",
              "name",
              "price",
              "type"
            ],
            "type" : "object",
            "properties" : {
              "name" : {
                "maxLength" : 2147483647,
                "minLength" : 3,
                "type" : "string"
              },
              "price" : {
                "type" : "number"
              },
              "description" : {
                "type" : "string"
              },
              "type" : {
                "type" : "string"
              }
            }
          },
          "CreateOrderRequest" : {
            "type" : "object",
            "properties" : {
              "items" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Item"
                }
              }
            }
          },
          "Item" : {
            "type" : "object",
            "properties" : {
              "idProduct" : {
                "type" : "string"
              },
              "quantity" : {
                "type" : "integer",
                "format" : "int32"
              },
              "itemValue" : {
                "type" : "number"
              },
              "totalItemValue" : {
                "type" : "number"
              }
            }
          },
          "RegisterClientRequest" : {
            "type" : "object",
            "properties" : {
              "name" : {
                "type" : "string"
              },
              "birthday" : {
                "type" : "string",
                "format" : "date"
              },
              "cpf" : {
                "type" : "string"
              },
              "email" : {
                "type" : "string"
              }
            }
          },
          "RegisterClientResponse" : {
            "type" : "object",
            "properties" : {
              "id" : {
                "type" : "string"
              }
            }
          },
          "CheckoutRequest" : {
            "type" : "object",
            "properties" : {
              "orderId" : {
                "type" : "string"
              }
            }
          },
          "GetOrderResponse" : {
            "type" : "object",
            "properties" : {
              "id" : {
                "type" : "string"
              },
              "items" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Item"
                }
              },
              "totalValue" : {
                "type" : "number"
              },
              "createdAt" : {
                "type" : "string",
                "format" : "date-time"
              },
              "updatedAt" : {
                "type" : "string",
                "format" : "date-time"
              },
              "status" : {
                "type" : "string",
                "enum" : [
                  "READY",
                  "IN_PREPARATION",
                  "RECEIVED",
                  "COMPLETED"
                ]
              },
              "paymentStatus" : {
                "type" : "string",
                "enum" : [
                  "PENDING",
                  "APPROVED",
                  "REJECTED"
                ]
              }
            }
          },
          "GetOrderPaymentStatusResponse" : {
            "type" : "object",
            "properties" : {
              "paymentStatus" : {
                "type" : "string",
                "enum" : [
                  "PENDING",
                  "APPROVED",
                  "REJECTED"
                ]
              }
            }
          },
          "GetClientResponse" : {
            "type" : "object",
            "properties" : {
              "id" : {
                "type" : "string"
              },
              "name" : {
                "type" : "string"
              },
              "birthday" : {
                "type" : "string",
                "format" : "date"
              },
              "cpf" : {
                "type" : "string"
              },
              "email" : {
                "type" : "string"
              },
              "creationTimestamp" : {
                "type" : "string",
                "format" : "date-time"
              },
              "updateTimestamp" : {
                "type" : "string",
                "format" : "date-time"
              }
            }
          },
          "CheckoutResponse" : {
            "type" : "object",
            "properties" : {
              "id" : {
                "type" : "string"
              },
              "orderId" : {
                "type" : "string"
              },
              "status" : {
                "type" : "string"
              },
              "createAt" : {
                "type" : "string",
                "format" : "date-time"
              }
            }
          }
        },
        "securitySchemes" : {
          "lambda_authorizer_cpf" : {
            "type" : "apiKey",
            "name" : "auth",
            "in" : "header",
            "x-amazon-apigateway-authtype" : "custom",
            "x-amazon-apigateway-authorizer" : {
              "type" : "request",
              "identitySource" : "method.request.header.cpf_cliente, method.request.header.senha_cliente",
              "authorizerCredentials" : var.lab_role_arn,
              "authorizerUri" : local.lambda_authorize_uri,
              "authorizerResultTtlInSeconds" : 0
            }
          }
        }
      }
    }
  )

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

resource "aws_api_gateway_stage" "postech_stage" {
  deployment_id = aws_api_gateway_deployment.postech_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
  stage_name    = "postech_stage"
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api_gateway_fiap_postech.id
}

