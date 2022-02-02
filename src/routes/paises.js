const Router = require("express-promise-router");
const db = require("../db");
const Pais = require("../models/Pais");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const paises = await Pais.findAll();
  res.json(paises);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const pais = await Pais.findById(id);
  res.json(pais);
});

//Crear uno
router.post("/", async (req, res) => {
  const row = await Pais.create(req.body);
  res.status(201).json(row);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Pais.update(id, req.body);
  res.json({ message: "Pais actualizado" });
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Pais.delete(id);
  res.json({ message: `Pais con id ${id} ha sido eliminado` });
});

module.exports = router;