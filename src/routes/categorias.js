const Router = require("express-promise-router");
const db = require("../db");
const Categoria = require("../models/Categoria");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const categorias = await Categoria.findAll();
  res.json(categorias);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const categoria = await Categoria.findById(id);
  res.json(categoria);
});

//Crear uno
router.post("/", async (req, res) => {
  const row = await Categoria.create(req.body);
  res.status(201).json(row);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Categoria.update(id, req.body);
  res.json({ message: "Categoria actualizada" });
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Categoria.delete(id);
  res.json({ message: `Categoria con id ${id} ha sido eliminada` });
});

module.exports = router;