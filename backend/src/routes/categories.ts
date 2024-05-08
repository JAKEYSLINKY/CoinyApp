
import express from "express";
import createCategory from "../controllers/category/createCategory";
import getCategory from "../controllers/category/getCategory";
const categoriessRouter = express.Router();

categoriessRouter.post("/create", createCategory); 
categoriessRouter.get("/get", getCategory);

export default categoriessRouter;
