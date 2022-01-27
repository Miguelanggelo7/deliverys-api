const Router = require("express-promise-router");
const db = require("../db");
const Cliente = require("../models/Cliente");

const router = new Router();

router.get("/",  async (req, res) => {
  const rows = await Cliente.findAll();
  res.send(rows);
});

module.exports = router;