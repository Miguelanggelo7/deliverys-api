const errorHandler = (err, req, res, next) => {
  if (err == "not-found") {
    if (req.method === "GET")
      return res.status(404).json({});
    
    if (req.method === "DELETE")
      return res.status(404).json({ message: "No se encontró el registro" });
  }

  else res.json({ message: "error" })
}

module.exports = errorHandler;