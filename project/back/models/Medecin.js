const User = require('./User');

class Medecin extends User {
    constructor(id, first_name, last_name, email, password, id_secu, age, city) {
        super(id, first_name, last_name, email, password, id_secu, age, city);
    }
}

module.exports = Medecin;