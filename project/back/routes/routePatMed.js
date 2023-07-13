module.exports = app => {
    const patMed = require("../controllers/patMedController.js");
    const { authenticateToken } = require("../service/auth.js");

    var router = require("express").Router();

    // Create an Invitation
    router.post("/invit", authenticateToken,  patMed.invit);

    // Get the list of PatMed with specific id_med
    router.get("/listMed/:id", authenticateToken, patMed.listMed);

    //Validate a PatMed //PUT verified in body
    router.put("/validate/:id", authenticateToken, patMed.validate);

    // Get all the pat_id validated by med_id
    router.get("/listPat/:id", authenticateToken, patMed.listPat);

    app.use('/api/patMed', router);
  };