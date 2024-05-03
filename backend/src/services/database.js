const mysql = require("mysql2");
const dotenv = require("dotenv");

dotenv.config();
const connection = mysql.createConnection({
	host: process.env.host,
	port: process.env.port,
	user: process.env.user,
	password: process.env.password,
	database: process.env.database,
});
module.exports = connection;
