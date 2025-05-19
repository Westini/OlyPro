import { MongoClient } from 'mongodb';
import { MONGODB_URI } from '$env/static/private';
import dotenv from 'dotenv';
dotenv.config();

/***
//check of monog uri
if (!MONGODB_URI) {
    throw new Error('Please define the MONGODB_URI environment variable');
}

const client = new MongoClient(MONGODB_URI);

export function start_mongo() {
	console.log('Starting mongo...');
	return client.connect();
}

export default client.db() 

***/

const uri = process.env['MONGODB_URI'];

let client
let clientPromise

if (!uri) {
    throw new Error('Please add your Mongo URI to .env.local')
}

if (process.env['NODE_ENV'] === 'development') {
    // In development mode, use a global variable 
    // so that the value is preserved across module reloads 
    // caused by HMR (Hot Module Replacement).
    if (!global._mongoClientPromise) {
        client = new MongoClient(uri)
        global._mongoClientPromise = client.connect()
    }
    clientPromise = global._mongoClientPromise
} else {
    // In production mode, it's best to 
    // not use a global variable.
    client = new MongoClient(uri)
    clientPromise = client.connect()
}

// Export a module-scoped MongoClient promise. 
// By doing this in a separate module, 
// the client can be shared across functions.
export default clientPromise