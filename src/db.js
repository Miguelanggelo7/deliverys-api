const mysql = require("mysql2/promise");

const db = mysql.createPool({
  connectionLimit: 5,
  host: process.env.HOST || "localhost",
  user: process.env.USER || "root",
  password: process.env.PASSWORD || "",
  database: process.env.DB || "",
});

module.exports = db;