const mysql = require('mysql2/promise');
const db = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'Laptop_BuyOnline'
});
module.exports = db;

