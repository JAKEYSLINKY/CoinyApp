import { PrismaClient } from "@prisma/client";
import { NextFunction, Request, Response } from "express";

const prisma = new PrismaClient();
const editPic = async (req: Request, res: Response, next: NextFunction) => {
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
export default editPic;
