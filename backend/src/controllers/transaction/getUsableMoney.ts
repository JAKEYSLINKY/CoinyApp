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

		
		return res.status(200).json({
			success: true,
			data: user,
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
