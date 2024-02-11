@automation-api
Feature: Agregar productos

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase

  @addProductCSV
  Scenario Outline: Agregar producto con csv
    And path '/api/v1/producto/'
    And request {codigo: <codigo>, nombre: <nombre>, medida: <medida>, marca: <marca>, categoria: <categoria>, precio: <precio>, stock: <stock>, estado: <estado>, descripcion: <descripcion>}
    When method post
    Then status 200
    * print response
    And match $.codigo == codigo
    And match $.id == '#notnull'

    Examples:
      | read('classpath:resources/product/dataNewProduct.csv') |

  @addProductJSON
  Scenario: Agregar producto con JSON
    And path '/api/v1/producto/'
    And request read("zbodyProd.json")
    When method post
    Then status 200
    And match $.id == '#notnull'

  @rejoinSameProduct
  Scenario Outline: Agregar producto Duplicado agregado anteriormente con csv
    And path '/api/v1/producto/'
    And request {codigo: <codigo>, nombre: <nombre>, medida: <medida>, marca: <marca>, categoria: <categoria>, precio: <precio>, stock: <stock>, estado: <estado>, descripcion: <descripcion>}
    When method post
    Then status 500
    * print response
    And match responseType == 'json'

    Examples:
      | read('classpath:resources/product/dataNewProduct.csv') |

  @addProductNull
  Scenario: Agregar producto con codigo vacío
    * def bodyNull =
      """
       {
        "codigo": "",
        "nombre": "ALTERNADOR PL200NS",
        "medida": "UND ",
        "marca": "Generico",
        "categoria": "Repuestos",
        "precio": "35.00",
        "stock": "48",
        "estado": "3",
        "descripcion": "ALTERNADOR PL200NS"
      }
      """
    And path '/api/v1/producto/'
    And request bodyNull
    When method post
    Then status 500
    * print response
    And match $.codigo[0] == 'The codigo field is required.'