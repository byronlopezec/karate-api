@pet
Feature: Admin Pet Store
  for help, see: https://petstore.swagger.io/#/

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def structPet = read("structPet.json")

  Scenario Outline: Add new pet Successfully
    * copy bodyPet = __row
    # Ingresar mascota
    Given path 'pet'
    And request bodyPet
    When method POST
    Then status 200
    And match response contains deep structPet
    * def petAdded = response
    * def idPet = response.id
    # consultar mascota
    Given path 'pet',idPet
    When method GET
    Then status 200
    And match response == petAdded
    Examples:
      | read("infoPets.json") |

#    @ignore
  Scenario Outline: Update pet Successfully
    # agregar nueva mascota
    * copy bodyPet = __row
    Given path 'pet'
    And request bodyPet
    When method POST
    Then status 200
    * copy petAdded = response
    # actualizar mascota
    * set petAdded.name = faker.name().fullName()
    * set petAdded.status = "sold"
    Given path 'pet'
    And request petAdded
    When method PUT
    Then status 200
    And match response contains deep structPet
    * def petUpdated = response
      # consultar mascota por status
    Given path 'pet','findByStatus'
    And param status = "sold"
    When method GET
    Then status 200
    And match response contains deep petUpdated

    Examples:
      | read("infoPets.json") |


