const karate = require("@karatelabs/karate");
const params = `src/* -T 4`;

karate.exec(params);
