const express = require("express");
const mountRoutes = require("./routes/index");
const app = express();

// Middlewares
app.use(express.json());

// Settings
app.set("port", process.env.PORT || 3000);

// Routing
mountRoutes(app);

module.exports = app;