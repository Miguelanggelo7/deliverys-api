const clientes = require("./clientes");
const direcciones = require("./direcciones");
const categorias = require("./categorias");
const vuelos = require("./vuelos");
const transportistas = require("./transportistas");
const articulos = require("./articulos");
const encomiendas = require("./encomiendas");
const nucleos = require("./nucleos");
const paises = require("./paises");
const invitaciones = require('./invitaciones');

module.exports = app => {
  app.use("/clientes", clientes);
  app.use("/direcciones", direcciones);
  app.use("/categorias", categorias);
  app.use("/vuelos", vuelos);
  app.use("/transportistas", transportistas);
  app.use("/articulos", articulos);
  app.use("/encomiendas", encomiendas);
  app.use("/nucleos", nucleos);
  app.use("/paises", paises);
  app.use('/invitaciones', invitaciones)
};