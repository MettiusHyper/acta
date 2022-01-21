import { Joi } from 'express-validation';

export const ID_REGEX = /\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b/;
export const TOKEN_HEADER = Joi.object({
	token: Joi.string().required(),
}).unknown();

export function parse(json: { [index: string]: string }): { [index: string]: any } {
	for (var el in json) {
		try {
			json[el] = JSON.parse(json[el]);
		} catch {}
	}
	return json;
}
