import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface planRequest {
	userId: number;
}
const resetPlan = async (req: Request, res: Response, next: NextFunction) => {
	try {
		const reqQuery: planRequest = {
			userId: Number(req.query.userId),
		};
		const today = new Date();
		const firstDayOfMonth = new Date(
			today.getFullYear(),
			today.getMonth(),
			1
		);
		const lastDayOfMonth = new Date(
			today.getFullYear(),
			today.getMonth() + 1,
			0
		);
		const plan = await prisma.plans.findFirst({
			where: {
				userId: reqQuery.userId,
				created: {
					gte: firstDayOfMonth,
					lte: lastDayOfMonth,
				},
			},
		});
		if (!plan) {
			return res.status(404).json({
				success: false,
				data: null,
				error: "no plan this month",
			});
		}
		await prisma.plans.delete({
			where: {
				planId: plan.planId,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Plan Delete Success",
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
export default resetPlan;
