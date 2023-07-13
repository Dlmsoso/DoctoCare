'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Pat_Med extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Pat_Med.init({
    id_pat: { type: DataTypes.INTEGER, allowNull: false},
    id_med: { type: DataTypes.INTEGER, allowNull: false},
    verified: { type: DataTypes.BOOLEAN, allowNull: false},
    name_pat: { type: DataTypes.STRING, allowNull: false},
    name_med: { type: DataTypes.STRING, allowNull: false},
  }, {
    sequelize,
    modelName: 'Pat_Med',
  });
  return Pat_Med;
};