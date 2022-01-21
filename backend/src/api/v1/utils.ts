import { Response, Request, NextFunction } from 'express';
import { useruid } from '../../utils/firebase.js';
import { v4 as uuidv4 } from 'uuid';
import { Joi, ValidationError } from 'express-validation';
import collection from '../../config/mongo.js';
import { ID_REGEX } from '../../utils/utils.js';

export const getUserDataFunc = async (req: Request, res: Response, next: NextFunction) => {
	let user = await useruid(req.headers.token as string);
	if (!user) return res.status(400).send({ message: 'provide a valid token' });

	let userData = await collection.findOne({ _id: user } as any);

	if (userData == null) {
		const listId = uuidv4();

		let userData = {
			_id: user,
			default_list: listId,
			tasks: [],
			lists: [{ id: listId, name: 'main', color: 'f8c15c', emoji: '😀' }],
		};
		await collection.insertOne(userData as any);
		res.locals.userData = userData;
	}
	res.locals.userData = userData;
	next();
};

export const getUserData = async (user: string) => {
	let userData = await collection.findOne({ _id: user } as any);

	if (userData == null) {
		const listId = uuidv4();

		let userData = {
			_id: user,
			default_list: listId,
			tasks: [],
			lists: [{ id: listId, name: 'main', color: 'f8c15c', emoji: '😀' }],
		};
		await collection.insertOne(userData as any);
		return userData;
	}
	return userData;
};

export const getUser = async (req: Request, res: Response, next: NextFunction) => {
	let user = await useruid(req.headers.token as string);
	if (!user) return res.status(400).send({ message: 'provide a valid token' });
	res.locals.user = user;
	next();
};

export const errorHandling = (err: any, req: Request, res: Response, next: any) => {
	if (err instanceof ValidationError) {
		for (let [key, value] of Object.entries(err.details)) {
			return res.status(err.statusCode).send({ message: value[0].message });
		}
	}
	return res.status(500).json(err);
};

export const JoiList = {
	name: Joi.string(),
	color: Joi.string().length(6),
	emoji: Joi.string(),
};

export const JoiTask = {
	name: Joi.string(),
	date: Joi.number(),
	color: Joi.string().length(6),
	description: Joi.string().allow(''),
	list: Joi.string().regex(ID_REGEX),
	check: Joi.bool(),
};
