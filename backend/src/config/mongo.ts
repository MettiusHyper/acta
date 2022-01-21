import { MongoClient } from 'mongodb';

const mongo = new MongoClient(process.env.MONGO as string);

await mongo.connect();

let collection = mongo.db('ToDo').collection('users');

export default collection;
