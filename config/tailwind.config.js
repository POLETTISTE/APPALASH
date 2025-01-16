const defaultTheme = require("tailwindcss/defaultTheme");
const plugin = require("tailwindcss/plugin");

module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html.haml,html.slim}",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/application.tailwind.css",
    "./app/javascript/**/*.js",
    "./public/*.html",
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
      addBase({
        ".translation_missing": {
          backgroundColor: "red",
          color: "white",
        },
      });
    }),
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
