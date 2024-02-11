@automation-api
Feature: Funcionalidad Registro

  Background:
    Given url urlBase

  @registroCorrecto
  Scenario Outline: Registro OK de <Descripcion>: <nombre>
    And path 'api/register'
    And request {email: <email>, password: <password>, nombre: <nombre>, tipo_usuario_id: <tipo_usuario_id>, estado: <estado>}
    When method post
    Then status 200
    And match $.data.nombre == <nombre>
    And match $.data.email == <email>
    And match $.data.password == '#notnull'
    And match $.data.tipo_usuario_id == <tipo_usuario_id>
    And match $.data.estado == <estado>
    And match $.access_token == '#notnull'
    And match $.token_type == "Bearer"

    Examples:
      | Descripcion | email                  | password   | nombre      | tipo_usuario_id | estado |
      | Usuario1    | "alejandro25@gmail.com" | "90909090" | "Alejandro" | 1               | 1      |
      | Usuario2    | "emiliano11@gmail.com"  | "90909090" | "Emiliano"  | 1               | 1      |
      | Usuario3    | "tammy27@gmail.com"     | "90909090" | "Tammy"     | 1               | 1      |

  @registroDuplicado
  Scenario: Registro Duplicado
    And path 'api/register'
    And request {email: "alejandro5@gmail.com", password: "90909090", nombre: "Alejandro", tipo_usuario_id: 1, estado: 1}
    When method post
    Then status 500
    And match $.email[0] == 'The email has already been taken.'


