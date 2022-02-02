const Router = require("express-promise-router");
const db = require("../db");
const Contiene = require("../models/Contiene");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Articulo.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:paquete/:articulo", async (req, res) => {
  const idPaquete = parseInt(req.params.paquete);
  const idArticulo = parseInt(req.params.articulo);
  const row = await Contiene.findById(idPaquete, idArticulo);
  res.json(row);
});

// Crear 
router.post("/", async (req, res) => {
  await Contiene.create(req.body);
  res.status(201).json({ message: "Articulo creado" });
});

// Actualizar 
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Contiene.update(id, req.body);
  res.json({ message: "Articulo actualizado" });
});

// Eliminar 
router.delete("/:paquete/:articulo", async (req, res) => {
  const idPaquete = parseInt(req.params.paquete);
  const idArticulo = parseInt(req.params.articulo);
  await Contiene.delete(idPaquete, idArticulo);
  res.json({ message: `Registro de la tabla contiene eliminado` });
});

module.exports = router;
