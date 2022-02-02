const Router = require("express-promise-router");
const db = require("../db");
const Vuelo = require("../models/Vuelo");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const vuelos = await Vuelo.findAll();
  res.json(vuelos);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const vuelo = await Vuelo.findById(id);
  res.json(vuelo);
});

//Crear uno
router.post("/", async (req, res) => {
  const row = await Vuelo.create(req.body);
  res.status(201).json(row);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Vuelo.update(id, req.body);
  res.json({ message: "Vuelo actualizado" });
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Vuelo.delete(id);
  res.json({ message: `Vuelo con id ${id} ha sido eliminado` });
});

module.exports = router;