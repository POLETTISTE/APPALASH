// tailwind.config.js
const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    // Ensure views and other files are included in the content array for purging unused styles
    "./app/views/**/*.{html.erb,html.haml,html.slim}",
    "./app/helpers/**/*.rb",
    // "./app/assets/stylesheets/application.scss",
    "./app/assets/stylesheets/application.tailwind.css", // Include Tailwind CSS file here
    "./app/javascript/**/*.js",
    "./public/*.html",
  ],
  theme: {
    extend: {
      // Add custom color
      colors: {
        "custom-pink": "#FF64A5", // Custom color example
      },
      // Extend default fonts with 'Inter var'
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    // Enable useful plugins for forms, typography, and container queries
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
