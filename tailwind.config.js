// tailwind.config.js

module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html.haml,html.slim}", // Ensure views are included
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/application.scss",
  ],
  theme: {
    extend: {
      colors: {
        "custom-pink": "#FF64A5", // Example custom color
      },
    },
  },
  plugins: [],
};
