import express, { Router, Response } from 'express';

import v1 from '../v1/v1.js';

const router: Router = express.Router();

router.get('/status', async (req, res: Response) => res.send({ message: 'OK' }));

router.use('/v1', v1);

export default router;
