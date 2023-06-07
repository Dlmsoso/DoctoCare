const User = require('./User');

class Patient extends User {
    constructor(id, first_name, last_name, email, password, id_secu, age, city, id_med, child) {
        super(id, first_name, last_name, email, password, id_secu, age, city);
        this.id_med = id_med;
        this.child = child;
    }
}

module.exports = Patient;