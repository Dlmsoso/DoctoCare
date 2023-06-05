const User = require('../models/User');

const getAllUsers = (req, res) => {
    // Logique pour récupérer tous les utilisateurs depuis la base de données
    // Utilisation de la classe User pour interagir avec la base de données
    const users = [{'id': 1, 'name': 'John Doe'}, {'id': 2, 'name': 'NIK'}];
    res.json(users);
  };

module.exports = {
    getAllUsers,
}