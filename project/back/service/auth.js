const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');

// get config vars
dotenv.config();

const secret = process.env.TOKEN_SECRET;

function generateAccessToken(username) {
    return jwt.sign(username, secret);
}

function authenticateToken(req, res, next) {
  const token = req.headers['authorization']
  //const token = authHeader && authHeader.split(' ')[1]

  if (token == null) return res.status(401).send({ auth: false, message: "Null Token" })

  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    console.log(err)

    if (err) return res.status(403).send({ auth: false, message: err })

    req.user = user

    next()
  })
}

module.exports = {
    generateAccessToken: generateAccessToken,
    authenticateToken: authenticateToken
};