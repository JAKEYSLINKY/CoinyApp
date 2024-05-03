import express, { Express } from "express";
import dotenv from "dotenv";
import plansRouter from "./routes/plans";

const app: Express = express();
const port = process.env.PORT;
dotenv.config();
app.use(express.json());
app.use("/plans", plansRouter);

app.listen(port, () => {
	console.log(`[server]: Server is running at http://localhost:${port}`);
});
