import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface categoryRequest {
	userId: number;
}
const editCategory = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	const reqQuery: categoryRequest = { userId: Number(req.query.userId) };
	try {
		const category =
			await prisma.$queryRaw`SELECT categoriesIcon.iconName,categories.name 
            FROM categoriesIcon,categories,userCategories
            WHERE userCategories.userId = ${reqQuery.userId} 
            AND categories.categoryId = userCategories.categoryId 
            AND categories.iconId = categoriesIcon.iconId;`;
		if (!category) {
			return res.status(404).json({
				success: false,
				data: null,
				error: "Category not found",
			});
		}
		return res.status(200).json({
			success: true,
			data: category,
			error: null,
		});
	} catch (error: any) {
		console.error("Error:", error);
		return res.status(500).json({
			success: false,
			data: null,
			error: error.message,
		});
	} finally {
		await prisma.$disconnect();
	}
};
export default editCategory;
