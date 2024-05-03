const connection = require("../../services/database");
const regis = async (req, res) => {
	const { username, password } = req.body;
	function possiblePassword(password) {
		return (
			password.length >= 8 &&
			/[a-z]/.test(password) &&
			/[A-Z]/.test(password) &&
			/\d/.test(password)
		);
	}
	if (!possiblePassword(password)) {
		return res.json({
			success: false,
			data: null,
			error: "Password must contain at least 8 characters with 1 Uppercase, 1 Lowercase and 1 number",
		});
	}
	try {
		await connection
			.promise()
			.query(
				`insert into users (username,password) values ('${username}','${password}')`
			);
		return res.status(200).json({
			success: true,
			data: "Registration success",
			error: null,
		});
	} catch (error) {
		console.error("Error:", error);
		return res.status(500).json({
			success: false,
			data: null,
			error: error.message,
		});
	}
};
module.exports = regis;
