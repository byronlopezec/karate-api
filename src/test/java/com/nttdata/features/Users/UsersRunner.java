package com.nttdata.features.Users;

// Si ejecutas: gradlew clean test -Dkarate.options="--tags @users" --info
// Se ejecuta este test tambien

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("users").relativeTo(getClass());
    }

}
