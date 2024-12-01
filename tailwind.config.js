const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        'primary-red': '#991b1b',
        'secondary-red': '#f87171',
  
        'primary-grey': '#57534e',
        'secondary-grey': '#d4d4d4',
  
        'background-red': '#fee2e2',
        'background-grey': '#e5e7eb',

        'button-red': '#ef4444',
        'button-hover-red': '#b91c1c',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
