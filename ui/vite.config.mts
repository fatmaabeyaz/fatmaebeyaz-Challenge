import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  // DÜZELTME: Yolu otomatik bulmayı deneme, doğrudan depo adını yaz.
  base: "/fatmaebeyaz-Challenge/",
  build: {
    outDir: "dist",
    assetsDir: "assets",
  },
});