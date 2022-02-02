const Router = require("express-promise-router");
const db = require("../db");
const Articulo = require("../models/Articulo");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Articulo.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Articulo.findById(id);
  res.json(row);
});

// Crear 
router.post("/", async (req, res) => {
  await Articulo.create(req.body);
  res.status(201).json({ message: "Articulo creado" });
});

// Actualizar 
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Articulo.update(id, req.body);
  res.json({ message: "Articulo actualizado" });
});

// Eliminar 
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Articulo.delete(id);
  res.json({ message: `Articulo con id ${id} ha sido eliminado` });
});

module.exports = router;