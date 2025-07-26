module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{rb,erb}'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        purple: {
          50: '#faf5ff',
          100: '#f3e8ff',
          200: '#e9d5ff',
          300: '#d8b4fe',
          400: '#c084fc',
          500: '#a855f7',
          600: '#9333ea',
          700: '#7c3aed',
          800: '#6b21a8',
          900: '#581c87',
          950: '#3b0764',
        },
        paper: {
          light: '#fefdfb',
          DEFAULT: '#faf8f3',
          dark: '#f5f3ed',
        },
        pastel: {
          orange: '#ffcc99',
          yellow: '#fff3b2',
          cyan: '#b3e5fc',
        }
      },
      fontFamily: {
        'serif': ['Crimson Text', 'Georgia', 'serif'],
        'sans': ['Source Sans 3', 'system-ui', 'sans-serif'],
        'display': ['Playfair Display', 'Georgia', 'serif'],
      },
      typography: {
        DEFAULT: {
          css: {
            color: '#1a1a1a',
            maxWidth: '65ch',
            a: {
              color: '#7c3aed',
              '&:hover': {
                color: '#6b21a8',
              },
            },
            '[class~="lead"]': {
              color: '#4a4a4a',
            },
            blockquote: {
              borderLeftColor: '#d8b4fe',
              color: '#4a4a4a',
            },
            h1: {
              fontFamily: 'Playfair Display, Georgia, serif',
              fontWeight: '700',
            },
            h2: {
              fontFamily: 'Playfair Display, Georgia, serif',
              fontWeight: '600',
            },
            h3: {
              fontFamily: 'Playfair Display, Georgia, serif',
              fontWeight: '600',
            },
          },
        },
        dark: {
          css: {
            color: '#e5e7eb',
            a: {
              color: '#c084fc',
              '&:hover': {
                color: '#d8b4fe',
              },
            },
            '[class~="lead"]': {
              color: '#d1d5db',
            },
            blockquote: {
              borderLeftColor: '#7c3aed',
              color: '#d1d5db',
            },
            h1: {
              color: '#f3f4f6',
            },
            h2: {
              color: '#f3f4f6',
            },
            h3: {
              color: '#f3f4f6',
            },
            strong: {
              color: '#f3f4f6',
            },
            code: {
              color: '#f3f4f6',
            },
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
}