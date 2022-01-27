const clientes = require("./clientes");

module.exports = app => {
  app.use("/clientes", clientes);
};