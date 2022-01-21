import express, { Application } from 'express';
import helmet from 'helmet';
import compression from 'compression';
import expressRL from 'express-rate-limit';

import router from '../api/routes/route.js';

const app: Application = express();

// parse body params and attach them to request.body
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// setting default rate limit
app.use(
	expressRL({
		windowMs: 1000 * 10, // 10 second
		max: 20, // limit each IP to 10 requests per 10 second
		message: 'Too many requests, try again later',
	})
);

// app security
app.use(helmet());

//compression
app.use(compression());

// removing powered by header as it could be used to reverse-engineer the api
app.disable('x-powered-by');

// mount router
app.use('/', router);

export default app;
