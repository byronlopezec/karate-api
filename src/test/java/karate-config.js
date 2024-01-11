function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

  karate.configure("logPrettyRequest",true)
  karate.configure("logPrettyResponse",true)
  karate.configure("continueOnStepFailure ",{ enabled: true, continueAfter: true, keywords: ['match','status'] })

  const datafaker = Java.type('net.datafaker.Faker');
  config.faker = new datafaker();
  return config;
}