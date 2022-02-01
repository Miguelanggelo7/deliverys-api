const clientes = require("./clientes");
const direcciones = require("./direcciones");
const categorias = require("./categorias");
const vuelos = require("./vuelos");
const transportistas = require("./transportistas");

module.exports = app => {
  app.use("/clientes", clientes);
  app.use("/direcciones", direcciones);
  app.use("/categorias", categorias);
  app.use("/vuelos", vuelos);
  app.use("/transportistas", transportistas);
};