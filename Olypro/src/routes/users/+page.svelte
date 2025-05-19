<script lang="ts">
    import { enhance } from '$app/forms';
    let error = '';
    let success = '';

    function validateForm(formData: FormData) {
        //get all input values
        const username = formData.get('username')?.toString() ?? '';
        const email = formData.get('email')?.toString() ?? '';
        const password = formData.get('password')?.toString() ?? '';
        const confirmPassword = formData.get('confirmPassword')?.toString() ?? '';

        if (!username || username.length < 3) {
            error = 'Username must be at least 3 characters long';
            return false;
        }

        if (!email || !email.includes('@')) {
            error = 'Please enter a valid email address';
            return false;
        }

        if (!password || password.length < 8) {
            error = 'Password must be at least 8 characters long';
            return false;
        }

        if (password !== confirmPassword) {
            error = 'Passwords do not match';
            return false;
        }

        return true;
    }
</script>

<div>
    <h1>Create Account</h1>
    
    {#if error}
        <div>
            {error}
        </div>
    {/if}
    
    {#if success}
        <div>
            {success}
        </div>
    {/if}

    <form method="POST" action="?/signup" use:enhance={({ formData }) => {
        if (!validateForm(formData)) {
            return;
        }
        return async ({ result }) => {
            if (result.type === 'success') {
                success = 'Account created successfully!';
                error = '';
            } else {
                error = result.error || 'Something went wrong';
                success = '';
            }
        };
    }}>
        <div>
            <label for="username">Username</label>
            <input
                type="text"
                id="username"
                name="username"
                required
                minlength="3"
            />
        </div>

        <div>
            <label for="email">Email</label>
            <input
                type="email"
                id="email"
                name="email"
                required
            />
        </div>

        <div>
            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                required
                minlength="8"
            />
        </div>

        <div>
            <label for="confirmPassword">Confirm Password</label>
            <input
                type="password"
                id="confirmPassword"
                name="confirmPassword"
                required
                minlength="8"
            />
        </div>

        <button type="submit">
            Create Account
        </button>
    </form>
</div>

