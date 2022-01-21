import express, { Router, Response, Request } from 'express';
import { validate, Joi } from 'express-validation';
import { v4 as uuidv4 } from 'uuid';
import collection from '../../config/mongo.js';
import { ID_REGEX, parse, TOKEN_HEADER } from '../../utils/utils.js';
import { errorHandling, getUserData, getUser, JoiList } from './utils.js';

const list: Router = express.Router();

list.post(
	'/',
	validate({
		headers: TOKEN_HEADER,
		body: Joi.object(JoiList).fork(Object.keys(JoiList), (schema) => schema.required()),
	}),
	getUser,
	async (req: Request, res: Response) => {
		//generate list object
		let list = parse(req.body);
		list['id'] = uuidv4();
		list['name'] = list['name'].toString();

		//inserting the list
		let doc = await collection.updateOne({ _id: res.locals.user } as any, { $push: { lists: list } });
		if (doc.modifiedCount == 0) return res.status(404).send({ message: 'unable to find memeber' });

		//returning userData
		let userData = await getUserData(res.locals.user);
		res.status(201).send(userData);
	}
);

list.patch(
	'/:id',
	validate({
		headers: TOKEN_HEADER,
		params: Joi.object({
			id: Joi.string().regex(ID_REGEX).required(),
		}),
		body: Joi.object(JoiList),
	}),
	getUser,
	async (req: Request, res: Response) => {
		//getting the modified elements of the list
		let modifiedItems: { [index: string]: any } = {};
		for (let [key, value] of Object.entries(req.body)) {
			modifiedItems[`lists.$.${key}`] = value;
		}

		//updating the list in the db
		let doc = await collection.updateOne(
			{
				_id: res.locals.user,
				lists: {
					$elemMatch: { id: req.params.id },
				},
			} as any,
			{ $set: modifiedItems }
		);
		if (doc.matchedCount == 0) return res.status(404).send({ message: 'list not found' });

		//returning userData
		let userData = await getUserData(res.locals.user);
		res.send(userData);
	}
);

list.delete(
	'/:id',
	validate({
		headers: TOKEN_HEADER,
		params: Joi.object({
			id: Joi.string().regex(ID_REGEX).required(),
		}),
	}),
	getUser,
	async (req: Request, res: Response) => {
		//removing the task
		let doc = await collection.updateOne({ _id: res.locals.user } as any, {
			$pull: { lists: { id: req.params.id } },
		});
		if (doc.modifiedCount == 0) return res.status(404).send({ message: 'list not found' });

		//returning userData
		let userData = await getUserData(res.locals.user);
		res.send(userData);
	}
);

//error handling
list.use(errorHandling);

export default list;
