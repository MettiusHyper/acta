import admin from '../config/firebase.js';

export async function useruid(token: string): Promise<string | null> {
	try {
		let user = await admin.app().auth().verifyIdToken(token);
		return user.uid;
	} catch {
		return null;
	}
}
