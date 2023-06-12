const express = require('express');
const bodyParser = require('body-parser');

const patientService = require('./controller/PatientControl')
const chatService = require('./controller/ChatControl')

const app = express();
app.use(bodyParser.json());

app.get('/api/patients', (req, res) => {
  console.log("Get all patients")
  const patients = patientService.getAllPatients(req, res);
  
  res.json(patients);
});

app.get('/api/patients/:id', (req, res) => {
  console.log("Get patient by id")
  const patient = patientService.getPatientById(req, res);

  res.json(patient);
});

app.get('/api/messages/', (req, res) => {
  console.log("Get all messages")
  const patient = chatService.getAllChatMessage(req, res);

  res.json(patient);
});

app.get('/api/messages/:id', (req, res) => {
  console.log("Get sender's messages")
  const patient = chatService.getChatMessagebySender(req, res);

  res.json(patient);
});

/*
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
