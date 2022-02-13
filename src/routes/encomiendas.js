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
  const paquetes = req.body.paquetes;
  const encomienda = req.body.encomienda;
  const row = await Encomienda.create(paquetes, encomienda);
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
router.patch('/update-estado', async (req, res) => {
  const {encomienda_id, transportista_id} = req.body;
  await Encomienda.updateEstadoEncomienda(encomienda_id, transportista_id, null);
  res.json({ message: "Encomienda actualizada" });
});

//Poner encomienda en custodia
router.patch("/en-custodia", async (req, res) => {
  const {encomienda_id, transportista_id} = req.body;
  await Encomienda.updateEstadoEncomienda(encomienda_id, transportista_id, 'en custodia');
  res.json({ message: "Encomienda actualizada" });
});

//cancelar encomienda
router.patch("/cancelar", async (req, res) => {
  const {encomienda_id, transportista_id} = req.body;
  await Encomienda.updateEstadoEncomienda(encomienda_id, transportista_id, 'cancelada');
  res.json({ message: "Encomienda actualizada" });
});

//solicitar encomienda
router.patch("/solicitar", async (req, res) => {
  const { encomienda_id } = req.body;
  await Encomienda.solicitar(encomienda_id);
  res.json({ message: "Encomienda solicitada" });
});

module.exports = router;