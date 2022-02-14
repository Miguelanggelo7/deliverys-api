const Router = require("express-promise-router");
const Cliente = require("../models/Cliente");

const router = new Router();

// Obtener todos 
router.get("/", async (req, res) => {
  const rows = await Cliente.findAll();
  res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Cliente.findById(id);
  res.json(row);
});

router.get("/encomienda/:id", async (req, res) => {
  const id = req.params.id;
  const row = await Cliente.findByEncomienda(id);
  res.json(row);
});

// Crear cliente
router.post("/singup", async (req, res) => {
  const id = await Cliente.create(req.body);
  res.status(201).json({
    msg: 'Usuario creado con exito',
    'id': id
  });
});

// Actualizar cliente
router.put("/:id", async (req, res) => {
  const id = req.params.id;
  await Cliente.update(id, req.body);
  res.json({ message: "Cliente actualizado" });
});

// Eliminar cliente
router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  await Cliente.delete(id);
  res.json({ message: `Cliente con id ${id} ha sido eliminado` });
});

router.patch('/login', async (req, res) => {
  const {email, password} = req.body;
  const response = await Cliente.login(email, password);
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


router.patch('/recargar-saldo', async (req, res) => {
  const {id, monto} = req.body;
  const saldo = await Cliente.recargarSaldo(id, monto);
  res.status(200).json({msg: `Se ha recargado su saldo con exito, ahora posee ${saldo}`});
});

module.exports = router;