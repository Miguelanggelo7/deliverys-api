const clientes = require("./clientes");
const direcciones = require("./direcciones");

module.exports = app => {
  app.use("/clientes", clientes);
  app.use("/direcciones", direcciones);
};