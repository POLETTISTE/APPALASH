const defaultTheme = require("tailwindcss/defaultTheme");
const plugin = require("tailwindcss/plugin");

module.exports = {
  content: [
    "./app/**/*.{html,erb,js,jsx,ts,tsx,vue}", // Watch all the files in your app
  ],
  theme: {
    extend: {
      colors: {
        customBlue: "#C0FFD4",
        customPink: "#FF64A1",
        customGreen: "#00FFB0",
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    plugin(function ({ addBase, theme }) {
      // Inject custom CSS variables for Tailwind colors
      addBase({
        ":root": {
          "--blue": theme("colors.customBlue"),
          "--pink": theme("colors.customPink"),
        },
      });

      // Inject custom styles for .translation_missing
    }),
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
