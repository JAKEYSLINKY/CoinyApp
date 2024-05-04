import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface planningRequest {
	userId: number;
	monthly: number;
	save: number;
}
const createPlan = async (req: Request, res: Response, next: NextFunction) => {
	try {
		console.log(req.body);
		const reqBody: planningRequest = req.body;
		await prisma.plans.create({
			data: {
				userId: reqBody.userId,
				monthly: reqBody.monthly,
				save: reqBody.save,
			},
		});
		return res.status(200).json({
			success: true,
			data: "Plan created",
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

export default createPlan;
