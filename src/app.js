const express = require("express");
const morgan = require('morgan');
const cors = require('cors');
const mountRoutes = require("./routes/index");
const errorHandler = require("./errorHandler");
const app = express();

// Middlewares
app.use(express.json());
app.use(morgan('dev'));
app.use(cors());

// Settings
app.set("port", process.env.PORT || 3000);

// Routing
mountRoutes(app);

// Error Handler
app.use(errorHandler);

module.exports = app;