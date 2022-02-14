const Router = require("express-promise-router");
const db = require("../db");
const Paquete = require("../models/Paquete");

const router = new Router();

//Obtener todos
router.get("/", async (req, res) => {
  const paquetes = await Paquete.findAll();
  res.json(paquetes);
});

//Obtener uno
router.get("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  const paquete = await Paquete.findById(id);
  res.json(paquete);
});

router.get("/encomienda/:id", async (req, res) => {
  const id = req.params.id;
  const paquete = await Paquete.findByEncomienda(id);
  res.json(paquete);
});

//Crear uno
router.post("/", async (req, res) => {
  const row = await Paquete.create(req.body);
  res.status(201).json(row);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Paquete.update(id, req.body);
  res.json({ message: "Paquete actualizado" });
});

//Borrar
router.delete("/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  await Paquete.delete(id);
  res.json({ message: `Paquete con id ${id} ha sido eliminado` });
});

module.exports = router;