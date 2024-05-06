import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
interface planRequest {
	userId: number;
	planId: number;
}
const resetPlan = async (req: Request, res: Response, next: NextFunction) => {
	try {
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
