const Router = require("express-promise-router");
const db = require("../db");
const Transportista = require("../models/Transportista");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const transportistas = await Transportista.findAll();
  res.json(transportistas);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const transportista = await Transportista.findById(id);
  res.json(transportista);
});

//Crear uno
router.post("/", async (req, res) => {
  await Transportista.create(req.body);
  res.status(201).json({ message: "Transportista creado" });
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Transportista.update(id, req.body);
  res.json({message: "Transportista actualizado"});
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Transportista.delete(id);
  res.json({ message: `Transportista con id ${id} ha sido eliminado` });
});

module.exports = router;