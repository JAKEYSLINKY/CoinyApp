import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface goalRequest {
	userId: number;
	name: string;
	goalAmount: number;
}
const createGoal = async (req: Request, res: Response, next: NextFunction) => {
	try {
		const reqBody: goalRequest = req.body;
		await prisma.goals.create({
			data: {
				userId: reqBody.userId,
				name: reqBody.name,
				goalAmount: reqBody.goalAmount,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Goal created",
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
export default createGoal;
