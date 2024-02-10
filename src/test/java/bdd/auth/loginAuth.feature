Feature: Funcionalidad login

  Scenario: Login exitoso
    Given url urlBase
    And path 'api/login'
    And request {email: "carlosz@gmail.com", password: "12345678"}
    When method post
    Then status 200
    * print response
    And match $.access_token == '#notnull'
    And match $.user.email == 'carlosz@gmail.com'

  Scenario Outline: Casos de prueba login
    Given url urlBase
    And path 'api/login'
    And request {email: <email>, password: <password>}
    When method post
    Then status 200
    * print response
    And match $.access_token == '#notnull'
    And match $.user.email == 'carlosz@gmail.com'

    Examples:
      | email             | password |
      | carlosz@gmail.com | 12345678 |

  @login
  Scenario: Login exitoso
    Given url urlBase
    And path 'api/login'
    And request {email: "carlosz@gmail.com", password: "12345678"}
    When method post
    Then status 200
    * def token = $.access_token

  @loginUnsuccessfully
  Scenario Outline: Login sin éxito con <Descripcion>
    Given url urlBase
    And path 'api/login'
    And request {email: <email>, password: <password>}
    When method post
    Then status 401
    And match $.message == "Datos incorrectos"

    Examples:
      | Descripcion | email               | password |
      | Correo fake | carlosz@outlook.com | 12345678 |
      | Pass fake   | carlosz@gmail.com   | 87654321 |