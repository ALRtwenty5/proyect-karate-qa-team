@automation-api
Feature: Cambiar estado del producto

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase

  @changeStatusOK
  Scenario Outline: Cambiar estado con csv
    * def id = 10
    And path '/api/v1/producto/' + id
    And request {estado: <estado>}
    When method patch
    Then status 200
    And match $.estado == '<estado>'

    Examples:
      | read('classpath:resources/product/dataStatus.csv') |

  @changeSTatusOutRange
  Scenario: Cambiar estado fuera de rango con json
    * def id = 3
    * def status = {"estado": 11}
    And path '/api/v1/producto/' + id
    And request status
    When method patch
    Then status 500
    And match $.estado[0] == 'The estado must not be greater than 10.'

