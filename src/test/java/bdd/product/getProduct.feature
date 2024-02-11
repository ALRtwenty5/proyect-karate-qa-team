@automation-api
Feature: Listar productos

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase

  @getProductsExisting
  Scenario Outline: Obtener Producto Número: <id>
    And path '/api/v1/producto/' + <id>
    When method get
    Then status 200
    And match responseType == 'json'
    And match $.codigo == "PRO00"+<id>

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |

    @getProductsFake
    Scenario: Producto no encontrado
      * def id = 1001
      And path '/api/v1/producto/' + id
      When method get
      Then status 404
      * print response
      And match response == '#notnull'
      And match $.error == 'Producto no encontrado'

