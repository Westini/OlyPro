import { MongoClient } from 'mongodb';

// Create a cached connection variable
let cachedClient: MongoClient | null = null;

export async function connectToDatabase() {
    // If the connection exists, return it
    if (cachedClient) {
        return cachedClient;
    }

    // If no connection string is provided, throw an error
    if (!process.env.MONGODB_URI) {
        throw new Error('Please define the MONGODB_URI environment variable');
    }

    // Create a new connection
    const client = new MongoClient(process.env.MONGODB_URI);

    try {
        // Connect to the database
        await client.connect();
        console.log('Connected to MongoDB');
        
        // Cache the connection
        cachedClient = client;
        
        return client;
    } catch (error) {
        console.error('Error connecting to MongoDB:', error);
        throw error;
    }
}

// Function to get a specific database
export async function getDatabase(dbName: string) {
    const client = await connectToDatabase();
    return client.db(dbName);
}

// Function to get a specific collection
export async function getCollection(dbName: string, collectionName: string) {
    const db = await getDatabase(dbName);
    return db.collection(collectionName);
} 