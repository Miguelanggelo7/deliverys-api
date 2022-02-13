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
  const row = await Transportista.create(req.body);
  res.status(201).json(row);
});

//Actualizar
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Transportista.update(id, req.body);
  res.json({ message: "Transportista actualizado" });
});

//Actualizar disponibilidad
router.put("/:id/disponibilidad", async (req, res) => {
  const id = req.params.id;
  const disponibilidad = req.body.disponibilidad;
  await Transportista.updateDisponibilidad(id, disponibilidad);
  res.json({ message: "Disponibilidad de Transportista actualizada" });
});

//Asignar vehiculo a transportista
// router.post("/:id/vehiculo", async (req, res) => {
//   const id = req.params.id;
//   const vehiculo = req.body;
//   const row = await Transportista.createVehiculo(id, vehiculo);
//   res.status(201).json(row)
// });


//Borrar
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Transportista.delete(id);
  res.json({ message: `Transportista con id ${id} ha sido eliminado` });
});

module.exports = router;