import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface getUsableMoneyRequest {
	userId: number;
}
const getUsableMoney = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
		//get userId from query
		//const reqQuery: getUsableMoneyRequest = req.query;
		const reqQuery: getUsableMoneyRequest = {
			userId: Number(req.query.userId),
		};
		const user = await prisma.plans.findFirst({
			where: {
				userId: reqQuery.userId,
			},
			orderBy: {
				created: "desc",
			},
		});
		if (!user) {
			return res.status(404).json({
				success: false,
				data: null,
				error: "User not found",
			});
		}
		const timestamp = new Date(user.created);
		// Adding 1 because getMonth() returns a zero-based index (0 for January)
		const m = timestamp.getMonth() + 1;
		const y = timestamp.getDate();
		const numDays = (y: number, m: number) => new Date(y, m, 0).getDate();
		var usableMoney = user.monthly - user.save;
		var dailyExpense = usableMoney / numDays(y, m);
		return res.status(200).json({
			success: true,
			data: { usableMoney, dailyExpense },
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
export default getUsableMoney;
