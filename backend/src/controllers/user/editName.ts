import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
const editName = async (req: Request, res: Response, next: NextFunction) => {
	try { //ก่อนupdate find unique ของ user  prisma.user.findUnique if เป็นเนา
		const reqBody: userRequest = req.body;
		await prisma.users.update({
			where: {
				userId: reqBody.userId,
			},
			data: {
				name: reqBody.name,
			},
		});

		return res.status(200).json({
			success: true,
			data: "Name updated",
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
export default editName;
