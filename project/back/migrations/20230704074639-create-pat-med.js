'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Pat_Meds', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      id_pat: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      id_med: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      verified: {
        type: Sequelize.BOOLEAN,
        allowNull: false
      },
      name_pat: {
        type: Sequelize.STRING,
        allowNull: false
      },
      name_med: {
        type: Sequelize.STRING,
        allowNull: false
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Pat_Meds');
  }
};