const app = require("./app");
const db = require("./db");

const main = () => {
  app.listen(app.get("port"), async () => {
    console.log(`Server listening on port ${app.get("port")}`);
    const con = await db.getConnection();
    console.log(`Connected to ${con.config.database}`)
  })
};

main();