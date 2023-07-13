module.exports = app => {
    const user = require("../controllers/userController.js");
    const { authenticateToken } = require("../service/auth.js");

    var router = require("express").Router();

    // Create a User
    router.post("/", user.create);

    // Retrieve a User
    router.get("/find/:id", user.findOne);

    // Update a User
    router.put("/update/:id", authenticateToken, user.update);

    // Login a User
    router.post("/login", user.login);

    // Logout a User
    router.get("/logout", user.logout);

    // Get all the medecin  TO TEST
    router.get("/listMed", authenticateToken, user.findAllMed);

    app.use('/api/user', router);
  };