{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "Fast Food FIAP",
    "description" : "Projeto de um sistema para lanchonete realizado para a Pós-Graduação de Arquitetura de Sistemas da FIAP",
    "version" : "v1"
  },
  "servers" : [
    {
      "url" : "${load_balancer_dns}",
      "description" : "Generated server url"
    }
  ],
  "paths" : {
      "/": {
        "get": {
          "operationId": "GetPet",
          "responses": {
            "200": {
              "description": "200 response",
              "headers": {
                "Access-Control-Allow-Origin": {
                  "schema": {
                    "type": "string"
                  }
                }
              },
              "content": {}
            }
          },
          "x-amazon-apigateway-integration": {
            "httpMethod": "GET",
            "uri": "http://petstore.execute-api.us-east-1.amazonaws.com/petstore/pets",
            "responses": {
              "default": {
                "statusCode": "200",
                "responseParameters": {
                  "method.response.header.Access-Control-Allow-Origin": "'*'"
                }
              }
            },
            "passthroughBehavior": "when_no_match",
            "type": "http"
          }
        },
        "options": {
          "responses": {
            "200": {
              "description": "200 response",
              "headers": {
                "Access-Control-Allow-Origin": {
                  "schema": {
                    "type": "string"
                  }
                },
                "Access-Control-Allow-Methods": {
                  "schema": {
                    "type": "string"
                  }
                },
                "Access-Control-Allow-Headers": {
                  "schema": {
                    "type": "string"
                  }
                }
              },
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Empty"
                  }
                }
              }
            }
          },
          "x-amazon-apigateway-integration": {
            "responses": {
              "default": {
                "statusCode": "200",
                "responseParameters": {
                  "method.response.header.Access-Control-Allow-Methods": "'GET,OPTIONS'",
                  "method.response.header.Access-Control-Allow-Headers": "'Content-Type,X-Amz-Date,Authorization,X-Api-Key'",
                  "method.response.header.Access-Control-Allow-Origin": "'*'"
                }
              }
            },
            "requestTemplates": {
              "application/json": "{\"statusCode\": 200}"
            },
            "passthroughBehavior": "when_no_match",
            "type": "mock"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "PUT",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/products/{id}"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "DELETE",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/products/{id}"
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
        },
        "security" : [
          {
            "lambda_authorizer_cpf" : []
          }
        ],
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "GET",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/products"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "POST",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/products"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "GET",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/orders"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "POST",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/orders"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "GET",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/clients"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "POST",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/clients"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "GET",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/checkout"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "POST",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/checkout"
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
        },
        "x-amazon-apigateway-integration" : {
          "httpMethod" : "GET",
          "payloadFormatVersion" : "1.0",
          "type" : "HTTP_PROXY",
          "uri" : "${load_balancer_dns}/payment-status"
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
          "identitySource" : "method.request.header.cpf_cliente",
          "authorizerCredentials" : "arn:aws:iam::${accountid}:role/LabRole",
          "authorizerUri" : "arn:aws:apigateway:${region}:lambda:path/2024-04-22/functions/${lambda_arn}/invocations",
          "authorizerResultTtlInSeconds" : 300
        }
      }
    }
  }
}