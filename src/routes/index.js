const clientes = require("./clientes");
const direcciones = require("./direcciones");
const vuelos = require("./vuelos");
const transportistas = require("./transportistas");
const articulos = require("./articulos");
const encomiendas = require("./encomiendas");
const nucleos = require("./nucleos");
const paises = require("./paises");
const invitaciones = require('./invitaciones');
const recorridos = require('./recorridos');
const vehiculos = require('./vehiculos');
const paquetes = require('./paquetes');

module.exports = app => {
  app.use("/clientes", clientes);
  app.use("/direcciones", direcciones);
  app.use("/vuelos", vuelos);
  app.use("/transportistas", transportistas);
  app.use("/articulos", articulos);
  app.use("/encomiendas", encomiendas);
  app.use("/nucleos", nucleos);
  app.use("/paises", paises);
  app.use('/invitaciones', invitaciones);
  app.use('/recorridos', recorridos);
  app.use('/vehiculos', vehiculos);
  app.use('/paquetes', paquetes);
};