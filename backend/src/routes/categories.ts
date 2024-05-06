
import express from "express";
import createCategory from "../controllers/category/createCategory";
const categoriessRouter = express.Router();

categoriessRouter.post("/create", createCategory);  

export default categoriessRouter;
