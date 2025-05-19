import { fail } from '@sveltejs/kit';
import type { Actions } from './$types';
import bcrypt from 'bcrypt';
import clientPromise from '$lib/db/db';

export const actions = {
    signup: async ({ request}) => {
        const formData = await request.formData();
        const username = formData.get('username')?.toString();
        const email = formData.get('email')?.toString();
        const password = formData.get('password')?.toString();

        if (!username || !email || !password) {
            return fail(400, { error: 'All fields are required' });
        }

        try {
            const client = await clientPromise;
            const db = client.db();
            const users = db.collection('users');

            // Check if user already exists
            const existingUser = await users.findOne({
                $or: [{ username }, { email }]
            });

            if (existingUser) {
                return fail(400, { error: 'Username or email already exists' });
            }

            // Hash password
            const saltRounds = 10;
            const hashedPassword = await bcrypt.hash(password, saltRounds);

            // Create new user
            const newUser = {
                username,
                email,
                password: hashedPassword,
                createdAt: new Date(),
                updatedAt: new Date()
            };

            await users.insertOne(newUser);
            return { success: true };
        } catch (error) {
            console.error('Error creating user:', error);
            return fail(500, { error: 'Failed to create user' });
        }
    }
} satisfies Actions; 