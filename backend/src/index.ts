import express, { Express } from "express";
import dotenv from "dotenv";

const app: Express = express();
const port = process.env.PORT;
dotenv.config();

app.listen(port, () => {
	console.log(`[server]: Server is running at http://localhost:${port}`);
});
