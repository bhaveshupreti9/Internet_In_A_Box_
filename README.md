# Internet-in-a-Box Backend

## Setup Instructions

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Create a `.env` file in the backend directory with:
```
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/internet-in-a-box
JWT_SECRET=your_jwt_secret_key_here
NEWS_API_KEY=9f38bb87f50e4d959a26f70bef38a36d
NODE_ENV=development
```

### 3. Start MongoDB
```bash
# On Windows
mongod

# On macOS/Linux
brew services start mongodb-community
```

### 4. Run the Server
```bash
npm start
# Or for development with auto-reload:
npm run dev
```

Server will start at `http://localhost:5000`

## API Endpoints

### User Routes (`/api/users`)
- `POST /register` - Register new user
- `POST /login` - Login user
- `GET /profile` - Get user profile (protected)
- `POST /save-article` - Save article (protected)
- `POST /remove-saved-article` - Remove saved article (protected)

### Article Routes (`/api/articles`)
- `GET /` - Get all articles (with search & filter)
- `GET /external` - Fetch external articles from API
- `GET /:id` - Get single article
- `POST /` - Create article (protected)
- `PUT /:id` - Update article (protected)
- `DELETE /:id` - Delete article (protected)

### Contact Routes (`/api/contacts`)
- `POST /` - Submit contact form
- `GET /` - Get all contacts (admin)
- `GET /:id` - Get single contact (admin)
- `PUT /:id` - Update contact status (admin)

## Database Models

### User
- name, email, password, role, savedArticles, timestamps

### Article
- title, description, content, category, source, externalUrl, imageUrl, views, timestamps

### Contact
- name, email, subject, message, status, timestamps