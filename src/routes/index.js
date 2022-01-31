const clientes = require("./clientes");
const direcciones = require("./direcciones");
const categorias = require("./categorias");
const vuelos = require("./vuelos");

module.exports = app => {
  app.use("/clientes", clientes);
  app.use("/direcciones", direcciones);
  app.use("/categorias", categorias);
  app.use("/vuelos", vuelos);
};