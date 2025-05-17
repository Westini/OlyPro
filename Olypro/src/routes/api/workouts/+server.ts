import { json } from '@sveltejs/kit';
import { getCollection } from '$lib/db/connection';


//retrieve user
export async function GET() {
    try {
        const users = await getCollection('weightlifting', 'users');
        const result = await users.find({}).toArray();
        return json(result);
    } catch (error) {
        console.error('Error fetching users:', error);
        return json({ error: 'Failed to fetch users' }, { status: 500 });
    }
}

//insert user
export async function POST({ request }) {
    try {
        const user = await request.json();
        const users= await getCollection('weightlifting', 'users');
        const result = await users.insertOne(user);
        return json({ id: result.insertedId });
    } catch (error) {
        console.error('Error creating user:', error);
        return json({ error: 'Failed to create user' }, { status: 500 });
    }
} 