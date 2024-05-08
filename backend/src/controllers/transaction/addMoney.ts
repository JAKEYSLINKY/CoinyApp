import { PrismaClient, bonusUsage } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface addMoneyRequest {
	userId: number;
	amount: number;
	usage: bonusUsage;
	source: string;
}
const addMoney = async (req: Request, res: Response, next: NextFunction) => {
	try {
		const reqBody: addMoneyRequest = req.body;
		await prisma.bonus.create({
			data: {
				userId: reqBody.userId,
				amount: reqBody.amount,
				usage: reqBody.usage as bonusUsage,
				source: reqBody.source,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Money added",
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
export default addMoney;
