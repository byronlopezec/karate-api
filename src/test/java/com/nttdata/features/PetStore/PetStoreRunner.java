package com.nttdata.features.PetStore;

// Si ejecutas: gradlew clean test -Dkarate.options="--tags @users" --info
// Se ejecuta este test tambien

import com.intuit.karate.junit5.Karate;

class PetStoreRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("pet").relativeTo(getClass());
    }

}
