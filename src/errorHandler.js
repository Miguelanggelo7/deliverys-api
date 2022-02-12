const errorHandler = (err, req, res, next) => {
  if (err == "not-found") {
    if (req.method === "GET")
      return res.status(404).json({});
    
    if (req.method === "DELETE")
      return res.status(404).json({ message: "No se encontró el registro" });
  }

  // No ha podido procesar la solicitud (error de cliente no de servidor)
  else res.status(400).json({ Error: err.message })

  // TODO: error de servidor
}

module.exports = errorHandler;