'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
    }
  }
  User.init({
    first_name: DataTypes.STRING,
    last_name: DataTypes.STRING,
    email: DataTypes.STRING,
    password: DataTypes.STRING,
    id_secu: DataTypes.INTEGER,
    age: DataTypes.INTEGER,
    city: DataTypes.STRING,
    is_med: DataTypes.BOOLEAN,
    id_adeli: DataTypes.INTEGER,
    med_spe : DataTypes.STRING,
    child: DataTypes.BOOLEAN
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};