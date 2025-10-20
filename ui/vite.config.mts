import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig(() => {
  const base = process.env.GITHUB_REPOSITORY 
    ? `/${process.env.GITHUB_REPOSITORY.split('/')[1]}/`
    : '/';
    
  return {
    plugins: [react()],
    base: "https://github.com/fatmaabeyaz/fatmaebeyaz-Challenge",
    build: {
      outDir: "dist",
      assetsDir: "assets",
    },
  };
});
