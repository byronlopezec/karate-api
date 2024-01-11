function fn(){
  const generate = ({id,name}) =>{
   const data = {
    "id": id,
    "category": {
      "id": faker.number().numberBetween(1, 100),
      "name": name + " " +faker.animal().name()
    },
    "name": faker.animal().name(),
    "photoUrls": [
      'https://example.com/photos/' + faker.internet().uuid() + '.jpg'
    ],
    "tags": [
      {
        "id": faker.number().numberBetween(1, 100),
        "name": faker.lorem().words(1)[0]
      }
    ],
    "status": ['available','sold','pending'][faker.number().numberBetween(0, 2)]
  }
  return data
  }

  return {generate}
}
