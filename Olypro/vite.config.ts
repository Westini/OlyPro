import { sveltekit } from '@sveltejs/kit/vite'
import { defineConfig } from 'vite'


export default defineConfig({
	plugins: [sveltekit()],
	optimizeDeps: {
		exclude: ['@rollup/rollup-win32-x64-msvc', 'clsx']
	}
});
