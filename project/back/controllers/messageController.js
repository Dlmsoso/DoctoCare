const db = require("../models");
const Message = db.message;
const Op = db.Sequelize.Op;

// Create and Save a new Tutorial
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
    return;
  }

  const message = {
    sender: req.body.sender,
    recipient: req.body.recipient,
    content: req.body.content,
    thread_id: req.body.thread_id,
    thread_name: req.body.thread_name,
  };

  Message.create(message)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Tutorial."
      });
    });
};

// Retrieve all Tutorials from the database.
exports.findAll = (req, res) => {
  Message.findAll()
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving tutorials."
      });
    });
};

// Find a single Tutorial with an id
exports.findThread = (req, res) => {
  const id = req.params.id;
  Message.findAll({ where: { thread_id: id } })
    .then(data => {
      if (data) {
        res.send(data);
      } else {
        res.status(404).send({
          message: `Cannot find Tutorial with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Tutorial with id=" + id
      });
    });
};

//delete all the messages of a thread
exports.deleteThread = (req, res) => {
  const id = req.params.id;
  Message.destroy({ where: { thread_id: id } })
    .then(num => {
      console.log(num);
      if (num > 0) {
        res.send({
          message: "Messages of thread was deleted successfully!"
        });
      } else {
        res.status(400).send({
          message: `Cannot delete messages of thread with id=${id}. Maybe thread was not found!`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Could not delete messages of thread with id=" + id
      });
    });
};