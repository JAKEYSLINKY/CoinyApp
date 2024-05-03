import express from "express";
import createPlan from "../controllers/plans/createPlan";
const plansRouter = express.Router();

plansRouter.post("/create", createPlan);

export default plansRouter;
