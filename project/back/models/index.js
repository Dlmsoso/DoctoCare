'use strict';

const dbConfig = require("../config/config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: "mysql",
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.message = require("./message.js")(sequelize, Sequelize);
db.user = require("./user.js")(sequelize, Sequelize);
db.pat_med = require("./pat_med.js")(sequelize, Sequelize);

module.exports = db;
