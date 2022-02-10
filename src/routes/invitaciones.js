const Router = require("express-promise-router");
const Invitacion = require("../models/Invitaciones");

const router = new Router();

//aceptar
router.patch("/aceptar", async (req, res) => {
    const { encomienda_id, transportista_id, vehiculo_id } = req.query;
    await Invitacion.aceptar(encomienda_id, transportista_id, vehiculo_id);
    res.json({ message: "Solicitud rechazada" });
});

//rechazar
router.patch("/rechazar", async (req, res) => {
    const { encomienda_id, transportista_id} = req.query;
    await Invitacion.rechazar(encomienda_id, transportista_id);
    res.json({ message: "Solicitud aceptada" });
});

module.exports = router;