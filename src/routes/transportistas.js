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

router.get('/encomienda/:id', async (req, res) => {
  const id = req.params.id;
  const transportista = await Transportista.findByEncomienda(id);
  res.json(transportista);
});

//Crear uno
router.post("/singup", async (req, res) => {
  const id = await Transportista.create(req.body);
  res.status(201).json({
    msg: 'Usuario creado con exito',
    'id': id
  });
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


//Borrar
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Transportista.delete(id);
  res.json({ message: `Transportista con id ${id} ha sido eliminado` });
});

router.patch('/login', async (req, res) => {
  const {email, password} = req.body;
  const response = await Transportista.login(email, password);
  if (response.is_password_correct) {
    res.status(200).json({
      msg: `Ha iniciado sesion con exito`,
      id: response.id
    });
  }else{
    res.status(400).json({
      msg: 'El password es incorrecto'
    });
  }
  
});

router.patch('/retirar-saldo', async (req, res) => {
  const {id, monto} = req.body;
  const saldo = await Transportista.retirarSaldo(id, monto);
  res.status(200).json({msg: `Se ha retirado su saldo con exito, ahora posee ${saldo}`});
});

module.exports = router;