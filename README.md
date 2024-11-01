# API DATING APP

## Setup

    npm install

    configure db connection -> `src/config/database.ts`

    npm run dev

## 1. Sign up

curl -X POST http://localhost:3001/api/signup \
 -H "Content-Type: application/json" \
 -d '{"name":"M Rahmat","email":"mrah@example.com","password":"password123","gender":"Male"}'

## 2. Login

curl -X POST http://localhost:3001/api/login \
 -H "Content-Type: application/json" \
 -d '{"email":"mrah@example.com","password":"password123"}'

## 3. Get Potential Matches (use token from login)

curl -X GET http://localhost:3001/api/matches \
 -H "Authorization: Bearer **GENERATED_TOKEN**"

## 4. Swipe on a User

curl -X POST http://localhost:3001/api/swipe/16 \
 -H "Authorization: Bearer **GENERATED_TOKEN**" \
 -H "Content-Type: application/json" \
 -d '{"action":"like"}'
