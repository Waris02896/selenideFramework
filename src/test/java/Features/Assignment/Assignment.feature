Feature: CURD operations for o reqres.in

  Background:
    * url 'https://reqres.in'
    * header Accept = 'application/json'
    * def usersPath = '/api/users'

  @Question1
  Scenario: Fatch User list and assert total pages and total records
    Given path usersPath
    When method GET
    Then status 200
    And print response
    * def jsonResponse = response
    * def totalPages =  jsonResponse.total_pages
    * def totalRecords = jsonResponse.total
    Then match totalPages == 2
    And match totalRecords == 12

  Scenario: Create new user and assert ID assigned
    Given path usersPath
    And request {"name": "Waris", "Job": "QA Engineer"}
    When method POST
    Then status 201
    And print response
    * def newUserName = response.name
    * def newUserJob = response.Job
    * def newUserId = response.id
    And match newUserId != null
    And print newUserId

  Scenario: Create new user, update that user and assert data
    Given path usersPath
    And request {"name": "Waris", "Job": "QA Engineer"}
    When method POST
    Then status 201
    And print response
    * def newUserName = response.name
    * def newUserJob = response.JJob
    * def newUserId = response.id
    And match newUserId != null
    And print newUserId
    When path usersPath
    And path newUserId
    And request {"name": "Ali", "Job": "QA Automation Engineer"}
    And method PUT
    Then status 200
    And print response
    * def updateUserName = response.name
    * def updateUserJob = response.Job
    And match newUserName != updateUserName
    And match newUserName != 'Ali'
    And match newUserJob != updateUserJob
    And match newUserJob != "QA Automation Engineer"

  Scenario: Create new user, update that user's partial data and assert data
    Given path usersPath
    And request {"name": "Waris", "Job": "QA Engineer"}
    When method POST
    Then status 201
    And print response
    * def newUserName = response.name
    * def newUserJob = response.JJob
    * def newUserId = response.id
    And match newUserId != null
    And print newUserId
    When path usersPath
    And path newUserId
    And request {"name": "Waris Ali"}
    And method PUT
    Then status 200
    And print response
    * def updateUserName = response.name
    * def updateUserJob = response.Job
    And match newUserName != updateUserName
    And match newUserName != 'Waris Ali'
    And match newUserJob == updateUserJob

  Scenario: Create new user, Update that user and then delete
    Given path usersPath
    And request {"name": "Waris", "Job": "QA Engineer"}
    When method POST
    Then status 201
    And print response
    * def newUserName = response.name
    * def newUserJob = response.JJob
    * def newUserId = response.id
    And match newUserId != null
    And print newUserId
    When path usersPath
    And path newUserId
    And request {"name": "Waris Ali"}
    And method PUT
    Then status 200
    And print response
    * def updateUserName = response.name
    * def updateUserJob = response.Job
    And match newUserName != updateUserName
    And match newUserName != 'Waris Ali'
    And match newUserJob == updateUserJob
    When path usersPath
    And path newUserId
    And method Delete
    Then status 204
