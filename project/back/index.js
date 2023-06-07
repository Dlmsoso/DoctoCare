const express = require('express');
const bodyParser = require('body-parser');

const patientService = require('./controller/PatientControl')

const app = express();
app.use(bodyParser.json());

app.get('/api/patients', (req, res) => {
  console.log("Get all patients")
  const patients = patientService.getAllPatients(req, res);
  res.json(patients);
});

/*
app.post('/api/users', (req, res) => {
  // Logique pour créer un nouvel utilisateur
  const newUser = req.body;
  // Sauvegarder le nouvel utilisateur dans la base de données
  res.json(newUser);
});

app.put('/api/users/:id', (req, res) => {
  // Logique pour mettre à jour un utilisateur existant
  const userId = req.params.id;
  const updatedUser = req.body;
  // Mettre à jour l'utilisateur dans la base de données
  res.json(updatedUser);
});

app.delete('/api/users/:id', (req, res) => {
  // Logique pour supprimer un utilisateur existant
  const userId = req.params.id;
  // Supprimer l'utilisateur de la base de données
  res.json({ message: 'Utilisateur supprimé avec succès' });
});
*/

app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});
