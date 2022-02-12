const Router = require("express-promise-router");
const Articulo = require("../models/Articulo");
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
  const row = await Articulo.findById(idPaquete, idArticulo);
  res.json(row);
});

router.get("/:paquete", async (req, res) => {
  const idPaquete = req.params.paquete;
  const row = await Articulo.findByPaqueteId(idPaquete);
  res.json(row);
});

// Crear 
router.post("/", async (req, res) => {
  const row = await Articulo.create(req.body);
  res.status(201).json(row);
});

// Actualizar 
router.put("/:paquete/:articulo", async (req, res) => {
  const id = req.params.id;
  await Articulo.update(id, req.body);
  res.json({ message: "Articulo actualizado" });
});

// Eliminar 
router.delete("/:paquete/:articulo", async (req, res) => {
  const idPaquete = parseInt(req.params.paquete);
  const idArticulo = parseInt(req.params.articulo);
  await Articulo.delete(idPaquete, idArticulo);
  res.json({ message: `Articulo con id ${id} ha sido eliminado` });
});

module.exports = router;
