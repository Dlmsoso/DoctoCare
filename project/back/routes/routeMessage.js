module.exports = app => {
    const message = require("../controllers/messageController.js");
    const user = require("../controllers/userController.js");

    var router = require("express").Router();
  
    // Retrieve all messages
    router.get("/", message.findAll);

    // Create a message
    router.post("/", message.create);

    //GetAll messages from Thread
    router.get("/:id", message.findThread)

    // Delete all messages from thread
    router.delete("/:id", message.deleteThread);

    app.use('/api/message', router);
  };