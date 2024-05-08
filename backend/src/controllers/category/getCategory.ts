import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface categoryRequest {
	userId: number;
	name: string;
	iconName: string;
}
const getCategory = async (req: Request, res: Response, next: NextFunction) => {
	try {
		const reqBody: categoryRequest = req.body;
		const categoryName = await prisma.categoriesIcon.findFirst({
			where: {
				iconName: reqBody.iconName,
			},
		});
		if (!categoryName) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "Wrong category name",
			});
		}
		const create = await prisma.categories.create({
			data: {
				name: reqBody.name,
				iconId: categoryName.iconId,
			},
		});
		await prisma.userCategories.create({
			data: {
				userId: reqBody.userId,
				categoryId: create.categoryId,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Category created",
			error: null,
		});
	} catch (error: any) {
		console.error("Error:", error);
		return res.status(500).json({
			success: false,
			data: null,
			error: error.message,
		});
	}
};
export default getCategory;
