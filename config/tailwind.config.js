const defaultTheme = require("tailwindcss/defaultTheme");
const plugin = require("tailwindcss/plugin");

module.exports = {
  content: [
    "./app/**/*.{html,erb,js,jsx,ts,tsx,vue}", // Watch all the files in your app
  ],
  // for example if css in helper, it doesnt this.precompile, so thnaks to it it is precompiled
  safelist: [
    "border-b-8", // Safelist border-b-8 (add more dynamic classes here)
    "border-t-8", // Safelist border-b-8 (add more dynamic classes here)
    "border-l-8", // Safelist border-b-8 (add more dynamic classes here)
    "border-r-8",
    "border-8",
    "font-semibold transition duration-200 relative group text-base md:text-lg lg:text-xl", // Safelist border-b-8 (add more dynamic classes here)
    // You can add more dynamic classes here if needed, e.g.
    // 'text-center', 'bg-red-500', 'border-t-4', etc.
  ],
  theme: {
    extend: {
      colors: {
        customBlue: "#75F4F4",
        customPink: "#FF579F",
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
