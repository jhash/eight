# OAuth Setup Instructions

To enable Google and GitHub OAuth authentication, follow these steps:

## Google OAuth Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Google+ API
4. Go to "Credentials" → "Create Credentials" → "OAuth client ID"
5. Select "Web application"
6. Add authorized redirect URIs:
   - `http://localhost:3000/auth/google_oauth2/callback` (for development)
   - `https://yourdomain.com/auth/google_oauth2/callback` (for production)
7. Copy the Client ID and Client Secret

## GitHub OAuth Setup

1. Go to GitHub Settings → Developer settings → OAuth Apps
2. Click "New OAuth App"
3. Fill in:
   - Application name: Eight
   - Homepage URL: `http://localhost:3000` (for development)
   - Authorization callback URL: `http://localhost:3000/auth/github/callback`
4. Copy the Client ID and Client Secret

## Environment Variables

Add the credentials to your `.env` file:

```
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
GITHUB_CLIENT_ID=your_github_client_id_here
GITHUB_CLIENT_SECRET=your_github_client_secret_here
```

## Running the Application

Start the Rails server with Tailwind CSS compilation:

```bash
bin/dev
```

The application will be available at http://localhost:3000