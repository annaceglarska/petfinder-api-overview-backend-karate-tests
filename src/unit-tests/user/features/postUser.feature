Feature: POST new user
    I want to create new user.
    I want to test different scenarios:
    1. Correct request:
    - status code 201,
    - response should return correct data shape - object with fields: id, email, name, surname, phone,
    - response should contain exactly the same key values that was sent in the request
    2. Incorrect request:
    - status code 415,
    - data response with error information

  Background: 
    * def urlBase = karate.get('baseUrl') + '/v1/user/create-user'

  Scenario: Post new user

    * def uuid = function(){return Math.floor((Math.random()*1000000))}
    * def email = `test-${uuid()}@test.com`
    * def newUser = { "email": '#(email)', "name": "test", "surname": "testTest", "phone": "111222333", "password": "test", "repeat_password": "test"}

    Given url urlBase
    And request newUser
    And header Accept = 'application/json'
    When method POST
    Then status 201
    And match response == {data: { _id: '#string',  email: '#string', name: '#string', surname: '#string', phone: "#string"}, message: "#string"}
    And match response.data.email == newUser.email
    And match response.data.name == newUser.name
    And match response.data.surname == newUser.surname
    And match response.data.phone == newUser.phone

  Scenario: Return 415 Unsupported Media Type when payload is missing

    Given url urlBase
    And header Accept = 'application/json'
    When method POST
    Then status 415
    And match response == { data: null,  error: '#string', message: '#string'}
   


    