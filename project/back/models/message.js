'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Message extends Model {}
  Message.init({
    sender: DataTypes.INTEGER,
    recipient: DataTypes.INTEGER,
    content: DataTypes.TEXT,
    thread_id: DataTypes.INTEGER,
    thread_name : DataTypes.STRING,
  }, {
    sequelize,
    modelName: 'Message',
  });

  return Message
};

