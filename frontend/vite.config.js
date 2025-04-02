import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import fs from 'fs';
import path from 'path';

const resolvePath = (...segments) => path.resolve(...segments);

// Pobierz ścieżki z pliku .env
const keyPath = process.env.KEY_PATH;
const certPath = process.env.CERT_PATH;

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 5173,
    https: {
      key: fs.readFileSync(keyPath),
      cert: fs.readFileSync(certPath),
    },
  },
});
