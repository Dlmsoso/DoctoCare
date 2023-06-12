const Patient = require('../models/Patient');

const allPatients = [
    // id, first_name, last_name, email, password, id_secu, age, city, id_med, child
    new Patient(1, 'John', 'Doe', 'john.doe@gmail.com', '123456', '123456789012345', 30, 'Paris', 1, false),
    new Patient(2, 'Maxime', 'Ulmann', 'maxime.ulmann@gmail.com', 'test', '000000000000123', 22, 'Saint-Maur', 1, false),
    new Patient(3, 'Solène', 'Loveland', 'prout.prout@gmail.com', 'prout', '000000000000666', 8, 'Nul', 5, true),
]

const getAllPatients = (req, res) => {
    const patients = allPatients;

    // process the data to exclude the id and password
    patients.forEach((patient) => {
        delete patient.id;
        delete patient.password;
    });

    res.json(patients);
}

const getPatientById = (req, res) => {
    const patientId = req.params.id;
    const patient = allPatients.find(p => p.id == patientId);

    if (patient === undefined) {
        res.status(404).send(`Patient with id ${patientId} not found.`);
        return;
    }

    delete patient.password;

    res.json(patient);
}

module.exports = {
    getAllPatients,
    getPatientById,
}