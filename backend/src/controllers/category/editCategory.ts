import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface categoryRequest {
	userId: number;
	categoryId: number;
	iconName: string;
	categoryName: string;
}
const editCategory = async (
	req: Request,
	res: Response,	
	next: NextFunction
) => {
	const reqBody: categoryRequest = req.body;
	try {
		const category = await prisma.userCategories.findFirst({
			where: {
				categoryId: reqBody.categoryId,
				userId: reqBody.userId,
			},
		});
		if (!category) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "Category not found",
			});
		}
		const icon = await prisma.categoriesIcon.findFirst({
			where: {
				iconName: reqBody.iconName,
			},
		});
		if (!icon) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "Icon not found",
			});
		}
		await prisma.categories.update({
			where: {
				categoryId: reqBody.categoryId,
			},
			data: {
				iconId: icon.iconId,
				name: reqBody.categoryName,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Edited success",
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
