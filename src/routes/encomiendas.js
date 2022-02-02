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

module.exports = router;