/*Feature: Ejemplos practicos Karate
/    @CP07
/    Scenario: Crear un post con docString en variable
/    * def body = read('classpath:resources/json/auth/bodyLogin.json')
/    Given url "https://jsonplaceholder.typicode.com"
/    And path "posts"
/    And request body
/    When method post
/    Then status 201
/    And match response.title == "foo"
/    And match response.body == "bar"
/    And match response.userId == 1
//



    Background:
        * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login')
        * def token = responseLogin.token
        Given header Authorization = 'Bearer ' + token
        And url urlBase

    Scenario Outline: Agregar producto con csv
        And path '/api/v1/producto/'
        And request {codigo: <codigo>, nombre: <nombre>, medida: <medida>, marca: <marca>, categoria: <categoria>, precio: <precio>, stock: <stock>, estado: <estado>, descripcion: <descripcion>}
        When method post
        Then status 200
        * print response
        And match $.codigo == "TC0996"
        And match $.id == '#notnull'

        Examples:
            |read('classpath:resources/product/dataNewProduct.csv')|

