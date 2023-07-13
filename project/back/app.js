const express = require('express');
const app = express();
const dotenv = require('dotenv');

dotenv.config();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const db = require("./models")  

db.sequelize.sync()
  .then(() => {
    console.log("Synced db.");
  })
  .catch((err) => {
    console.log("Failed to sync db: " + err.message);
  });

require("./routes/routeMessage")(app);
require("./routes/routeUser")(app);
require("./routes/routePatMed")(app);

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Welcome to DoctoCare API !');
});

app.listen(PORT, () => {
  console.log(`Serveur en cours d'exécution sur le port ${PORT}`);
});