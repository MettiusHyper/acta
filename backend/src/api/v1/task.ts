import express, { Router, Response, Request } from 'express';
import { validate, Joi } from 'express-validation';
import { v4 as uuidv4 } from 'uuid';
import collection from '../../config/mongo.js';
import { ID_REGEX, parse, TOKEN_HEADER } from '../../utils/utils.js';
import { errorHandling, getUserData, getUserDataFunc, JoiTask } from './utils.js';

const task: Router = express.Router();

task.post(
	'/',
	validate({
		headers: TOKEN_HEADER,
		body: Joi.object(JoiTask).fork(Object.keys(JoiTask), (schema) => schema.required()),
	}),
	getUserDataFunc,
	async (req: Request, res: Response) => {
		if (!res.headersSent) {
			//generate task object
			let task = parse(req.body);
			task['id'] = uuidv4();
			task['name'] = task['name'].toString();

			//list check (you cannot add a task to a non-existing list)
			let list: any = await collection.findOne({
				$and: [{ _id: res.locals.user }, { lists: { $elemMatch: { id: task.list } } }],
			} as any);
			if (!list) return res.status(400).send({ message: 'list not found' });

			//inserting the task
			let doc = await collection.updateOne({ _id: res.locals.user } as any, { $push: { tasks: task } });
			if (doc.modifiedCount == 0) return res.status(404).send({ message: 'unable to find memeber' });

			//returning userData
			let userData = await getUserData(res.locals.user);
			res.status(201).send(userData);
		}
	}
);

task.patch(
	'/:id',
	validate({
		headers: TOKEN_HEADER,
		params: Joi.object({
			id: Joi.string().regex(ID_REGEX).required(),
		}),
		body: Joi.object(JoiTask),
	}),
	getUserDataFunc,
	async (req: Request, res: Response) => {
		//getting the modified elements of the task
		let modifiedItems: { [index: string]: any } = {};
		for (let [key, value] of Object.entries(parse(req.body))) {
			modifiedItems[`tasks.$.${key}`] = value;
		}

		if (modifiedItems['tasks.$.list']) {
			//list check (you cannot add a task to a non-existing list)
			let list: any = await collection.findOne({
				$and: [{ _id: res.locals.user }, { lists: { $elemMatch: { id: modifiedItems['tasks.$.list'] } } }],
			} as any);
			if (!list) return res.status(400).send({ message: 'list not found' });
		}

		//updating the task in the db
		let doc = await collection.updateOne(
			{
				_id: res.locals.user,
				tasks: {
					$elemMatch: { id: req.params.id },
				},
			} as any,
			{ $set: modifiedItems }
		);
		if (doc.matchedCount == 0) return res.status(404).send({ message: 'task not found' });

		//returning userData
		let userData = await getUserData(res.locals.user);
		res.send(userData);
	}
);

task.delete(
	'/:id',
	validate({
		headers: TOKEN_HEADER,
		params: Joi.object({
			id: Joi.string().regex(ID_REGEX).required(),
		}),
	}),
	getUserDataFunc,
	async (req: Request, res: Response) => {
		//removing the task
		let doc = await collection.updateOne({ _id: res.locals.user } as any, {
			$pull: { tasks: { id: req.params.id } },
		});
		if (doc.modifiedCount == 0) return res.status(404).send({ message: 'task not found' });

		//returning userData
		let userData = await getUserData(res.locals.user);
		res.send(userData);
	}
);

//error handling
task.use(errorHandling);

export default task;
