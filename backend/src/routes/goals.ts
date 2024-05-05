import express from 'express';
import createGoal from '../controllers/goal/createGoal';
import addGoalMoney from '../controllers/goal/addGoalMoney';
import getGoal from '../controllers/goal/getGoal';
import updateGoal from '../controllers/goal/updateGoal';
const goalsRouter = express.Router();

goalsRouter.post('/create', createGoal);
goalsRouter.patch('/add', addGoalMoney);
goalsRouter.get('/get', getGoal);
goalsRouter.patch('/update', updateGoal);

export default goalsRouter;