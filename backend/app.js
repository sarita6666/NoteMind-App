const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Backend funcionando");
});

const PORT = process.env.PORT || 3000;

if (process.env.NODE_ENV !== "production") {
  app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
  });
}

module.exports = app;