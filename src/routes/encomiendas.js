const Router = require("express-promise-router");
const db = require("../db");
const Encomienda = require("../models/Encomienda");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Encomienda.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Encomienda.findById(id);
  res.json(row);
});

// Crear 
router.post("/", async (req, res) => {
  const row = await Encomienda.create(req.body);
  res.status(201).json(row);
});

// Actualizar 
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Encomienda.update(id, req.body);
  res.json({ message: "Encomienda actualizada" });
});

// Eliminar 
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Encomienda.delete(id);
  res.json({ message: `Encomienda con id ${id} ha sido eliminada` });
});


//Actualizar estado de encomienda
router.put("/update-estado/:encomienda_id/:transportista_id", async (req, res) => {
  const [encomienda_id, transportista_id] = req.params;
  await Transportista.updateEstadoEncomienda(encomienda_id, transportista_id, null);
  res.json({ message: "Encomienda actualizada" });
});

//Poner encomienda en custodia
router.put("/en-custodia/:encomienda_id/:transportista_id", async (req, res) => {
  const [encomienda_id, transportista_id] = req.params;
  await Transportista.updateEstadoEncomienda(encomienda_id, transportista_id, 'en custodia');
  res.json({ message: "Encomienda actualizada" });
});

//cancelar encomienda
router.put("/cancelar/:encomienda_id/:transportista_id", async (req, res) => {
  const [encomienda_id, transportista_id] = req.params;
  await Transportista.updateEstadoEncomienda(encomienda_id, transportista_id, 'cancelada');
  res.json({ message: "Encomienda actualizada" });
});

module.exports = router;