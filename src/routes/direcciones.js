const Router = require("express-promise-router");
const db = require("../db");
const Direccion = require("../models/Direccion");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const direcciones = await Direccion.findAll();
  res.json(direcciones);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const direccion = await Direccion.findById(id);
  res.json(direccion);
});

//Crear uno
router.post("/", async (req, res) => {
  const direccion = await Direccion.create(req.body);
  res.status(201).json(direccion);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const direccion = await Direccion.update(id, req.body);
  res.json(direccion);
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Direccion.delete(id);
});

module.exports = router;