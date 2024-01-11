@pet @parallel=false
Feature: Admin Pet Store
  for help, see: https://petstore.swagger.io/#/

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def structPet = read("structPet.json")
    * def randomPet = call read("randomPet.js")

  @findPet @ignore
  Scenario: CA01: find pet Successfully
    # consultar mascota
    Given path 'pet',idPet
    When method GET
    Then status 200

  @findByStatus
  Scenario: CA02: search pets by status
    Given path 'pet','findByStatus'
    And param status = "sold"
    When method GET
    Then status 200

  @addNewPet
  Scenario Outline: CA03: Add new pet Successfully <name>
    * copy bodyPet = randomPet.generate(__row)
    # Ingresar mascota
    Given path 'pet'
    And request bodyPet
    When method POST
    Then status 200
    And match response contains deep structPet
    * copy petAdded = response
    * copy idPet = response.id
    # consultar mascota
    * def petFound = call read('@findPet') ({idPet})
    * print petFound
    And match petFound.response == petAdded
    Examples:
      | read("newPets.csv") |

  @updatePet
  Scenario Outline: CA04: Update pet Successfully - <name>
    # agregar nueva mascota
    * copy bodyPet = randomPet.generate(__row)
    Given path 'pet'
    And request bodyPet
    When method POST
    Then status 200
    * copy petAdded = response
    # actualizar mascota
    * set petAdded.name = faker.name().fullName()
    * set petAdded.status = <statusPet>
    Given path 'pet'
    And request petAdded
    When method PUT
    Then status 200
    And match response contains deep structPet
    * copy petUpdated = response
      # validar si la mascota se encuentra actualizada
    * def listPetsByStatus = call read('@findByStatus')
    And match listPetsByStatus.response contains deep petUpdated
    Examples:
      | read("currentPets.csv") |

