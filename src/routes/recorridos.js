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
router.patch("/aceptar-recorrido", async (req, res) => {
  const { encomienda_id, recorrido_id, transportista_id, nucleo_des_id } = req.body;
  const result = await Recorrido
    .aceptarRecorrido(encomienda_id, recorrido_id, transportista_id, nucleo_des_id);
  res.json(result);
});

// terminar recorrido
router.patch("/terminar-recorrido", async (req, res) => {
  const { encomienda_id, recorrido_id } = req.body;
  const result = await Recorrido
    .terminarRecorrido(encomienda_id, recorrido_id);
  res.json(result);
});

module.exports = router;