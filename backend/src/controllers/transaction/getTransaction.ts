import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface transactionRequest {
	userId: number;
}
const getTransaction = async (
	req: Request,
	res: Response,
	next: NextFunction
) => {
	try {
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
		const reqQuery: transactionRequest = {
			userId: Number(req.query.userId),
		};
		const transactions = await prisma.transactions.findMany({
			where: {
				userId: reqQuery.userId,
				created: {
					gte: firstDayOfMonth,
					lte: lastDayOfMonth,
				},
			},
		});
		if (!transactions) {
			return res.status(400).json({
				success: false,
				data: null,
				error: "This user hasnt made any transactions yet",
			});
		}
		return res.status(200).json({
			success: true,
			data: transactions,
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
export default getTransaction;
