import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/ts/index.tsx',
                'resources/css/app.css',
                'resources/sass/app.scss',
            ],
            refresh: true,
        }),
        react(),
    ],
    css: {
        preprocessorOptions: {
            scss: {
                api: "modern-compiler",
            },
            // sassの場合は
            // sass: {
            //   api: "modern-compiler",
            // },
        },
    },
});
