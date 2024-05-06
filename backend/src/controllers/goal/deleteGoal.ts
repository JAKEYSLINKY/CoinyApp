import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface goalRequest {
	userId: number;
	goalId: number;
}
const deleteGoal = async (req: Request, res: Response, next: NextFunction) => {
	try {
		const reqBody: goalRequest = {
			userId: Number(req.query.userId),
			goalId: Number(req.query.goalId),
		};
		await prisma.goals.delete({
			where: {
				goalId: reqBody.goalId,
				userId: reqBody.userId,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Goal deleted",
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
export default deleteGoal;
