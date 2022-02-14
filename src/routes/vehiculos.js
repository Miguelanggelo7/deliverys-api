const Router = require("express-promise-router");
const Vehiculo = require("../models/Vehiculo");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Vehiculo.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Vehiculo.findById(id);
  res.json(row);
});

// Crear Vehiculo
router.post("/", async (req, res) => {
  const vehiculo = await Vehiculo.create(req.body);
  res.status(201).json({
    msg: 'Vehiculo creado con exito',
    'vehiculo': vehiculo
  });
});

// Actualizar Vehiculo
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Vehiculo.update(id, req.body);
  res.json({ message: "Vehiculo actualizado" });
});

// Eliminar Vehiculo
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Vehiculo.delete(id);
  res.json({ message: `Vehiculo con id ${id} ha sido eliminado` });
});

module.exports = router;