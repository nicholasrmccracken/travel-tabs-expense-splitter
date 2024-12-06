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
      gap: {
        '10p': '10%',
      },
      colors: {
        'primary-red': '#991b1b',
        'secondary-red': '#f87171',
  
        'primary-grey': '#57534e',
        'secondary-grey': '#d4d4d4',
  
        'background-red': '#fee2e2',
        'background-grey': '#e5e7eb',

        'button-red': '#ef4444',
        'button-hover-red': '#b91c1c',

        'primary': '#5e2807', // dark logo
        'off_white': '#f2f0ef', // light logo color
  
        'accent_red': '#bf0000',
        'accent_green': '#64c7A0',

        'pale_brown': '#d0b8b2',
        'light_brown': '#AD7064',
        'medium_brown': '#7B554D',
        'dark_brown': '#2E0B05',

        'scarlet-red': '#BB0000',
        'gray': '#666666',
        'light-gray': '#CCCCCC',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      backgroundImage: {
        'logo': "url('/assets/light_logo.png')",
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
