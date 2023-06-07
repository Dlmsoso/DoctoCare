class User {
    constructor(id, first_name, last_name, email, password, id_secu, age, city) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.password = password;
        this.id_secu = id_secu;
        this.age = age;
        this.city = city;
    }
}

module.exports = User;