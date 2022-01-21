import dotenv from 'dotenv';
if (!process.env.NODE_ENV) {
	dotenv.config();
}

const app = await import('./config/express.js');

app.default.listen(process.env.PORT, () => console.info(`Server started on port ${process.env.PORT}`));
