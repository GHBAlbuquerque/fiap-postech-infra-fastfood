resource "aws_api_gateway_rest_api" "postech_openapi" {
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
          "url" : "http://localhost:8080",
          "description" : "Generated server url"
        }
      ],
      "paths" : {
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
              "200" : {
                "description" : "Success"
              }
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
            }
          }
        },
        "/orders" : {
          "get" : {
            "tags" : [
              "order-controller"
            ],
            "operationId" : "getOrders",
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
              "200" : {
                "description" : "Success"
              }
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
            }
          }
        },
        "/checkout" : {
          "get" : {
            "tags" : [
              "checkout-controller"
            ],
            "operationId" : "findAll",
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
              "200" : {
                "description" : "Success"
              }
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
        }
      }
    }
  )

  name = "pos-tech-stage-test"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "postech_deployment" {
  rest_api_id = aws_api_gateway_rest_api.postech_openapi.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.postech_openapi.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "postech_stage_test" {
  deployment_id = aws_api_gateway_deployment.postech_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.postech_openapi.id
  stage_name    = "postech_stage_test"
}