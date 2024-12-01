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

        dark_logo: '#5e2807',
        light_logo: '#f2dfc9',
  
        red_accent: '#BF0000',
        green_accent: '#64C7A0',

        off_white: '#d0b8b2',
        light_brown: '#AD7064',
        medium_brown: '#7B554D',
        dark_brown: '#2E0B05',
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
