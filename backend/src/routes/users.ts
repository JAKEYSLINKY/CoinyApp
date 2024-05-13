import express from "express";
import editPic from "../controllers/user/editPic";
import editName from "../controllers/user/editName";
import getStat from "../controllers/user/getStat";
const usersRouter = express.Router();

usersRouter.patch("/edit/name", editName);
usersRouter.patch("/edit/profile", editPic);
usersRouter.get("/stat", getStat);

export default usersRouter;
