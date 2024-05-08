import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface goalMoneyRequest {
	userId: number;
	goalId: number;
	amount: number;
}
const addGoalMoney = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		const reqBody: goalMoneyRequest = req.body;
		const goal = await prisma.goals.findFirst({
			where: {
				goalId: reqBody.goalId,
				userId: reqBody.userId,
			},
		});
		if (!goal) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "This goal does not exist",
			});
		}
		const currentAmount = reqBody.amount + goal.currentAmount;
		if (
			currentAmount > goal.goalAmount ||
			reqBody.amount > goal.goalAmount
		) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "The amount is over the goal",
			});
		}
		if (currentAmount === goal.goalAmount) {
			await prisma.goals.update({
				where: {
					goalId: reqBody.goalId,
					userId: reqBody.userId,
				},
				data: {
					currentAmount: currentAmount,
					status: "completed",
				},
			});			
		}
		await prisma.goals.update({
			where: {
				goalId: reqBody.goalId,
				userId: reqBody.userId,
			},
			data: {
				currentAmount: currentAmount,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Money added to goal",
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
export default addGoalMoney;
