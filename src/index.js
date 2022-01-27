const app = require("./app");
const db = require("./db");

const main = () => {
  app.listen(app.get("port"), () => {
    console.log(`Server listening on port ${app.get("port")}`);
    console.log(`Connected to ${db.config.connectionConfig.database}`)
  })
};

main();