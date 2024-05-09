import { PrismaClient } from "@prisma/client";
// import exp from 'constants';
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface planRequest {
	userId: number;
}
interface userPlan {
	planId: number;
	userId: number;
	monthly: number;
	save: number;
	currentSave: number;
}

const getPlan = async (req: Request, res: Response, next: NextFunction) => {
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
				error: "No Plan on this month yet",
			});
		}
		const bonus = await prisma.bonus.aggregate({
			where: {
				userId: reqQuery.userId,
				usage: "save",
				created: {
					gte: firstDayOfMonth,
					lte: lastDayOfMonth,
				},
			},
			_sum: {
				amount: true,
			},
		});
		const userPlan: userPlan = {
			planId: plan.planId,
			userId: plan.userId,
			monthly: plan.monthly,
			save: plan.save,
			currentSave: plan.save + bonus._sum.amount!,
		};
		await prisma.plans.update({
			where: {
				planId: plan.planId,
			},
			data: {
				currentSave: plan.save + bonus._sum.amount!,
			},
		});
		return res.status(200).json({
			success: true,
			data: userPlan,
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

export default getPlan;
