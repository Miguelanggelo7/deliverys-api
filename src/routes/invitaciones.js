const Router = require("express-promise-router");
const Invitacion = require("../models/Invitaciones");

const router = new Router();

router.get("/", async (req, res) => {
    const rows = await Invitacion.findAll();
    res.json(rows);
});

// Obtener uno por su id
router.get("/:id", async (req, res) => {
    const id = req.params.id;
    const row = await Invitacion.findByTransportistaId(id);
    res.json(row);
});

//aceptar
router.patch("/aceptar", async (req, res) => {
    const { encomienda_id, transportista_id, vehiculo_id } = req.body;
    await Invitacion.aceptar(encomienda_id, transportista_id, vehiculo_id);
    res.json({ message: "Solicitud aceptada" });
});

//rechazar
router.patch("/rechazar", async (req, res) => {
    const { encomienda_id, transportista_id} = req.body;
    await Invitacion.rechazar(encomienda_id, transportista_id);
    res.json({ message: "Solicitud rechazada" });
});

module.exports = router;