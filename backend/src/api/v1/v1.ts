import express, { Router, Response, Request } from 'express';
import task from './task.js';
import list from './list.js';
import { getUserDataFunc } from './utils.js';

const v1: Router = express.Router();

v1.get('/userinfo', getUserDataFunc, async (req: Request, res: Response) => {
	if (!res.headersSent) {
		res.send(res.locals.userData);
	}
});

v1.use('/task', task);
v1.use('/list', list);

export default v1;
