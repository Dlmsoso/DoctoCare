const db = require("../models");
const User = db.user;
const Op = db.Sequelize.Op;
const hash = require('../service/hasher');
const auth = require('../service/auth');
const dotenv = require('dotenv');

dotenv.config();
const salt = process.env.salt;

exports.create = (req, res) => {
    // Validate request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
      return;
    }
  
    const user = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email: req.body.email,
        password: hash.hash(req.body.password),
        id_secu: req.body.id_secu,
        age: req.body.age,
        city: req.body.city,
        is_med: req.body.is_med,
        id_adeli: req.body.id_adeli,
        med_spe: req.body.med_spe,
        child: req.body.child,
    };  

    // if email already exist in database return error message
    if (User.findOne({ where: { email: user.email } })
      .then(data => {
        if (data) {
          res.status(400).send({
            message: "Email already exist"
          })}
        else {
          User.create(user)
          .then(data => {
            const token = auth.generateAccessToken({ username: req.body.username });
            res.json({auth: true, token : token, user: data});  
          })
          .catch(err => {
            res.status(500).send({
              message:
                err.message || "Some error occurred while creating the User."
            });
          });
        }
      }));
  
    
};

exports.update = (req, res) => {
  const id = req.params.id;

  User.update(req.body, {
    where: { id: id }
  })
    .then(num => {
      if (num == 1) {
        res.send({
          message: "User was updated successfully."
        });
      } else {
        res.send({
          message: `Cannot update User with id=${id}. Maybe User was not found or req.body is empty!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating User with id=" + id
      });
    });
};

// login logic

exports.login = (req, res) => {
  console.log("login route");
  const email = req.body.email;
  const password = req.body.password;

  User.findOne({ where: { email: email } })
    .then(data => {
      if (hash.compare(password, data.password)) {
        const token = auth.generateAccessToken({ username: req.body.username });

        delete data.dataValues.password;

        req.user = data.user;
        res.json({auth: true, token : token, user: data});

      } else {
        res.send({
          message: `Wrong password`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: err.message || "Some error occurred while retrieving User."
      });
    });
};

// disconnect logic

exports.logout = (req, res) => {
  req.user = null;
  res.json({auth: false, token : null});
}

// get all medecin
exports.findAllMed = (req, res) => {
  User.findAll({ where: { is_med: true } })
    .then(data => {
      if (data) {
        data.forEach(element => {
          delete element.dataValues.password;
          delete element.dataValues.createdAt;
          delete element.dataValues.updatedAt;
          delete element.dataValues.child;
          delete element.dataValues.is_med;
        });

        res.send(data);

      } else {
        res.status(404).send({
          message: `Cannot find Medecin`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Medecin"
      });
    });
}

// get pat by id
exports.findOne = (req, res) => {
  const id = req.params.id;

  User.findByPk(id)
    .then(data => {
      if (data) {
        delete data.dataValues.password;
        delete data.dataValues.id;
        delete data.dataValues.createdAt;
        delete data.dataValues.updatedAt;

        res.send(data);

      } else {
        res.status(404).send({
          message: `Cannot find User with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving User with id=" + id
      });
    });
}