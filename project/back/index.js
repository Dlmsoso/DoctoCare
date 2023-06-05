const express = require('express');
const bodyParser = require('body-parser');

// Créer une instance d'Express
const app = express();

// Middleware pour parser les données JSON
app.use(bodyParser.json());

// Routes de l'API
app.get('/api/users', (req, res) => {
  // Logique pour récupérer tous les utilisateurs depuis une base de données
  const users = [{ id: 1, name: 'John Doe' }, { id: 2, name: 'Jane Smith' }];
  res.json(users);
});

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

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});
