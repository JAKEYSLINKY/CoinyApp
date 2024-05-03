const connection = require("../../services/database");

const createCategory = async (req, res) => {
	const { category, icon } = req.body;
	try {
		await connection
			.promise()
			.query(
				`insert into categories (name,icon) values ('${category}','${icon}') `
			);
		return res.status(200).json({
			success: true,
			data: "Category created",
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
module.exports = createCategory;
