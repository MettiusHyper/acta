import admin from 'firebase-admin';

admin.initializeApp({
	credential: admin.credential.cert(JSON.parse(process.env.FIREBASE as string)),
	databaseURL: 'https://to-do-back-default-rtdb.europe-west1.firebasedatabase.app',
});

export default admin;
