import express from "express";
import createPlan from "../controllers/plan/createPlan";
import resetPlan from "../controllers/plan/resetPlan";
const plansRouter = express.Router();

plansRouter.post("/create", createPlan);
plansRouter.delete("/reset", resetPlan);

export default plansRouter;
