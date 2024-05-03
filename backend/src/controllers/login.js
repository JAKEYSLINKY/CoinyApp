const connection = require("../database/connection");
const login = async (req, res) => {
	const { username, password } = req.body;

	try {
		const userQuery = await connection
			.promise()
			.query(
				`select username,password from users where username='${username}' and password='${password}'`
			);
		const user = userQuery[0][0];
		if (!user) {
			return res.status(404).json({
				success: false,
				data: null,
				error: "User not found",
			});
		}
		return res.status(200).json({
			success: true,
			data: user,
			message: "Login success",
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
module.exports = login;