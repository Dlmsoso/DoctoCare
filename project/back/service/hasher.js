'use strict';
let bcrypt = require('bcrypt');

let hash = (password) => {
    if (password == null) {
        throw new Error('Must Provide Password and salt values');
    }
    if (typeof password !== 'string') {
        throw new Error('password must be a string and salt must either be a salt string or a number of rounds');
    }
    return bcrypt.hashSync(password, 12)
};

let compare = (password, passHash) => {
    if (password == null || hash == null) {
        throw new Error('Must Provide Password, Salt and Hash values');
    }

    bcrypt.hash(password, 12).then((hash) => {
        console.log(hash);
        console.log(passHash);
        return bcrypt.compare(passHash, hash)
            .then((result) => {
                console.log("result:", result);
            });
    });
}

module.exports = {
    hash: hash,
    compare: compare
};