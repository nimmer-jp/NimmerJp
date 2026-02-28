/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./main.nim",
    "./app/**/*.nim"
  ],
  theme: {
    extend: {
      boxShadow: {
        glow: "0 0 0 1px rgba(34, 211, 238, 0.16), 0 12px 40px rgba(0, 0, 0, 0.35)"
      }
    }
  },
  plugins: []
};
