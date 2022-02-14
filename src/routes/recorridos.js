const Router = require("express-promise-router");
const Recorrido = require("../models/Recorridos");


const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const recorridos = await Recorrido.findAll();
  res.json(recorridos);
});

// Obtener todos los recorridos disponibles de un nucleo determinado
router.get("/:nucleo_id", async (req, res) => {
  const { nucleo_id } = req.params;
  const recorridos = await Recorrido.findByNucleo(nucleo_id);
  res.json(recorridos);
});

//Obtener uno
router.get("/:encomienda_id/:recorrido_id", async (req, res) => {
  const { encomienda_id, recorrido_id } = req.params;
  const recorridos = await Recorrido.findById(encomienda_id, recorrido_id);
  res.json(recorridos);
});

// aceptar recorrido
router.patch("/aceptar", async (req, res) => {
  const { encomienda_id, recorrido_id, transportista_id, nucleo_des_id } = req.body;
  await Recorrido
    .aceptarRecorrido(encomienda_id, recorrido_id, transportista_id, nucleo_des_id);
  res.status(200).json({msg: 'recorrido aceptado'});
});

// terminar recorrido
router.patch("/terminar", async (req, res) => {
  const { encomienda_id, recorrido_id } = req.body;
  await Recorrido
    .terminarRecorrido(encomienda_id, recorrido_id);
  res.status(200).json({msg: 'recorrido terminado'});
});

module.exports = router;