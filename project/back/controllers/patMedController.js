const db = require("../models");
const PatMed = db.pat_med;
const User = db.user;
const Op = db.Sequelize.Op;

// Create a new PatMed
exports.invit = (req, res) => {
    // Validate request
    if (!req.body) {
        res.status(400).send({
        message: "Content cannot be empty!"
        });
        return;
    }
    
    // Create a PatMed
    const pat_med = {
        id_pat: req.body.id_pat,
        id_med: req.body.id_med,
        verified: false,
        name_pat: req.body.name_pat,
        name_med: req.body.name_med
    };
    
    // if pat_med already exist in database return error message
    if (PatMed.findOne({ where: { id_pat: pat_med.id_pat, id_med: pat_med.id_med } })
        .then(data => {
            if (data) {
                res.status(400).send({
                    message: "Invitation already exist"
                })}
            else {
                PatMed.create(pat_med)
                    .then(data => {
                        res.send(data);
                    })
                    .catch(err => {
                        res.status(500).send({
                            message:
                            err.message || "Some error occurred while creating the PatMed."
                        });
                    });
            }
        }
    ));
}

// Get the list of PatMed with specific id_med
exports.listMed = (req, res) => {
    const id = req.params.id;
    PatMed.findAll({ where: { id_med: id } })
        .then(data => {
            if (data) {
                for (let i = 0; i < data.length; i++) {
                    // replace id_pat with the user's name
                    delete data[i].dataValues.id_pat;
                    delete data[i].dataValues.id_med;
                }
                res.send(data);
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving PatMed with id_med=" + id
            });
        });
    };

// Validate a PatMed
exports.validate = (req, res) => {
    const id = req.params.id;

    PatMed.update(req.body, {
        where: { id: id }
    })
    .then(num => {
        if (num == 1) {
            res.send({
            message: "Invitation was validated successfully."
            });
        } else {
            res.send({
            message: `Cannot update PatMed with id=${id}. Maybe PatMed was not found`
            });
        }
    })
    .catch(err => {
        res.status(500).send({
        message: "Error updating PatMed with id=" + id
        });
    });
}

// Get all the pat_id validated by med_id
exports.listPat = (req, res) => {
    const id = req.params.id;
    PatMed.findAll({ where: { id_pat: id, verified: true } })
        .then(data => {
            if (data) {
                res.send(data);
            } else {
                res.status(404).send({
                    message: `Cannot find PatMed with id_med=${id}.`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving PatMed with id_pat=" + id
            });
        });
    }