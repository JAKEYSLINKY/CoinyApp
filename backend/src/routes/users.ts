import express from "express";
import editPic from "../controllers/user/editPic";
import editName from "../controllers/user/editName";
const usersRouter = express.Router();

usersRouter.patch("/edit/name", editName);
usersRouter.patch("/edit/profile", editPic);

export default usersRouter;
