# API DATING APP

The Basic Functionalities of the Dating App would be:

- Sign up & Login to the App

- User able to only view, swipe left (pass) and swipe right (like) 10 other dating profiles in total (pass + like) in 1 day.

  - Same profiles can't appear twice in the same day.

- User able to purchase premium packages that unlocks one premium feature. A few examples:

  - No swipe quota for user

  - Verified label for user

## Project Structure

### The service is organized as follows

    src
    ├── config
    │   └── database.ts          # Database configuration for connecting to MySQL
    ├── controllers              # Defines controllers handling API request logic
    ├── middleware               # Middleware for authentication and request handling
    ├── routes                   # Route definitions for each API endpoint
    ├── services
    │   └── userService.ts       # Core business logic for user actions (signup, login, swipe)
    ├── types                    # TypeScript type definitions for data structures

### Key Files

`database.ts`: Configures MySQL database connection details.

`UserService.ts`: Implements core logic for managing user accounts, login sessions, and swiping interactions.

`routes`: Maps URLs to the appropriate controllers and functions for handling requests.

`controllers`: Processes requests, calls service methods, and sends responses.

## Setup & Run the service

    npm install

    configure db connection -> `src/config/database.ts`

    npm run dev

## API usage samples

### 1. Sign up

    curl -X POST http://localhost:3001/api/signup \
    -H "Content-Type: application/json" \
    -d '{"name":"M Rahmat","email":"mrah@example.com","password":"password123","gender":"Male"}'

### 2. Login

    curl -X POST http://localhost:3001/api/login \
    -H "Content-Type: application/json" \
    -d '{"email":"mrah@example.com","password":"password123"}'

### 3. Get Potential Matches (use token from login)

    curl -X GET http://localhost:3001/api/matches \
    -H "Authorization: Bearer **GENERATED_TOKEN**"

### 4. Swipe on a User

    curl -X POST http://localhost:3001/api/swipe/16 \
    -H "Authorization: Bearer **GENERATED_TOKEN**" \
    -H "Content-Type: application/json" \
    -d '{"action":"like"}'

## Deployment Steps

### 1. Environment Setup

Environment Variables: Ensure all sensitive data, such as database credentials and JWT secrets, are stored in environment variables. You can use a .env file for local development, but avoid committing it to version control.

### 2. Build for Production

1. Install dependencies and build the project.

   npm install

   npm run build

This will create a dist folder with the compiled code ready for deployment.

2. Database Migration (if needed):

Set up a script or use an ORM like Sequelize or TypeORM to handle migrations if your database schema changes.

3. Configuration for Production Environment:

Set environment variables for production settings like NODE_ENV=production and database credentials.
Configure your server to serve the application from the dist directory.

4. Run in Production Mode

To start the application in production, use:

    NODE_ENV=production npm start
