import { defineConfig } from 'vite';
import preact from '@preact/preset-vite';

export default defineConfig({ base: '/admin/', plugins: [preact()] });
