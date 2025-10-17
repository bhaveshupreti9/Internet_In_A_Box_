# 📦 Internet-in-a-Box: Offline Knowledge System

A complete, fully functional MERN stack web application that creates a self-contained offline knowledge hub. Access essential information and tools without requiring an active internet connection.

## 🎯 Project Overview

Internet-in-a-Box is designed to empower users with resilient access to information during network outages, natural disasters, or restricted access zones. The system replicates essential internet experiences locally with:

- **Offline Knowledge Bases**: Store and access Wikipedia dumps, documentation, and learning content
- **Advanced Search**: Powerful retrieval capabilities with full-text search
- **Secure Authentication**: JWT-based user authentication with saved bookmarks
- **External Data Integration**: Fetch latest news when connectivity returns
- **Responsive UI**: Works seamlessly on mobile, tablet, and desktop
- **Analytics**: Track page visits and user engagement

## 🚀 Quick Start

### Prerequisites

- Node.js (v14+)
- MongoDB (running locally)
- npm or yarn

### 1. Clone & Setup Backend

```bash
cd backend
npm install
```

Create `.env` file:
```
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/internet-in-a-box
JWT_SECRET=your_jwt_secret_key_here
NEWS_API_KEY=9f38bb87f50e4d959a26f70bef38a36d
NODE_ENV=development
```

Start MongoDB:
```bash
# macOS
brew services start mongodb-community

# Windows
mongod

# Linux
sudo systemctl start mongod
```

Start backend server:
```bash
npm start
# or for development with auto-reload:
npm run dev
```

Server runs at `http://localhost:5000`

### 2. Setup Frontend

```bash
cd frontend
npm install
npm start
```

App opens at `http://localhost:3000`

## 📁 Folder Structure

```
internet-in-a-box/
├── backend/
│   ├── models/          # MongoDB schemas
│   │   ├── User.js
│   │   ├── Article.js
│   │   └── Contact.js
│   ├── routes/          # API endpoints
│   ├── controllers/      # Business logic
│   ├── config/          # Database configuration
│   ├── utils/           # Helper functions
│   ├── server.js
│   ├── .env
│   └── package.json
│
├── frontend/
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── components/  # React components
│   │   ├── pages/       # Page components
│   │   ├── services/    # API services
│   │   ├── context/     # Auth context
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css
│   ├── tailwind.config.js
│   └── package.json
│
├── .gitignore
└── README.md
```

## 🛠️ Tech Stack

### Backend
- **Node.js & Express**: Server and API framework
- **MongoDB & Mongoose**: NoSQL database and ODM
- **JWT**: Authentication and authorization
- **Bcrypt**: Password hashing
- **Axios**: HTTP client for external APIs
- **CORS**: Cross-origin resource sharing

### Frontend
- **React 18**: UI library with Hooks
- **React Router DOM**: Client-side routing
- **Axios**: API requests
- **Tailwind CSS**: Utility-first styling
- **Vite**: Fast build tool
- **Lucide React**: Icon library

## 🎨 Color Scheme

| Color | Hex Code | Purpose |
|-------|----------|---------|
| Primary Light Blue | `#D6E6F2` | Backgrounds |
| Secondary Purple | `#C8ABE6` | Accents & Hover |
| Accent Blue | `#6EB8E1` | Primary brand color |
| White | `#FFFFFF` | Text & Borders |

## 📚 API Endpoints

### User Routes (`/api/users`)
```
POST   /register              Register new user
POST   /login                 Login user
GET    /profile               Get user profile (protected)
POST   /save-article          Save article (protected)
POST   /remove-saved-article  Remove saved article (protected)
```

### Article Routes (`/api/articles`)
```
GET    /                      Get all articles (searchable)
GET    /external              Fetch external news articles
GET    /:id                   Get single article
POST   /                      Create article (protected)
PUT    /:id                   Update article (protected)
DELETE /:id                   Delete article (protected)
```

### Contact Routes (`/api/contacts`)
```
POST   /                      Submit contact form
GET    /                      Get all contacts (admin)
GET    /:id                   Get single contact (admin)
PUT    /:id                   Update contact status (admin)
```

## 🔐 Authentication

- **JWT Tokens**: 7-day expiration
- **Password Hashing**: Bcrypt with 10 salt rounds
- **Protected Routes**: Client-side route guards
- **Token Storage**: localStorage for persistence

## ✨ Key Features

### Home Page
- Hero section with call-to-action
- Feature showcase (4 key features)
- "How it works" section
- Page visit analytics counter

### Explore Page
- Full-text search across articles
- Filter by category (Technology, Science, History, Education, Documentation)
- Two tabs: Offline Knowledge & Latest News
- External API integration (NewsAPI)
- Responsive article cards with images

### Saved Articles
- Bookmark articles for later reading
- Only accessible to logged-in users
- View article metadata and stats
- Remove bookmarks with one click
- External link access

### Contact Page
- Beautiful contact form
- Contact information display
- Success feedback message
- Form validation and error handling

### Authentication
- Unified login/register modal
- Password confirmation validation
- Email uniqueness check
- JWT-based session management
- Persistent login across sessions

## 🚀 How It Works

### 1. **Browse**
Users explore the offline knowledge base or fetch latest news. Articles are displayed in responsive cards with search and filter capabilities.

### 2. **Search**
Full-text search across article titles, descriptions, and content. Category-based filtering for quick navigation.

### 3. **Save**
Authenticated users can bookmark articles. Saved articles are stored in the database and linked to their user profile.

### 4. **Access**
View saved articles anytime from the dedicated "Saved" page with quick links to external sources.

## 🔄 Data Flow

```
Frontend (React) 
    ↓
Axios HTTP Requests
    ↓
Backend API (Express)
    ↓
Controllers (Business Logic)
    ↓
MongoDB Database
    ↓
JSON Response
    ↓
State Management (React Context)
    ↓
UI Rendering (Components)
```

## 📊 Database Schema

### User Model
```javascript
{
  name: String,
  email: String (unique),
  password: String (hashed),
  role: String (user/admin),
  savedArticles: [ObjectId],
  createdAt: Date,
  updatedAt: Date
}
```

### Article Model
```javascript
{
  title: String,
  description: String,
  content: String,
  category: String,
  source: String,
  externalUrl: String,
  imageUrl: String,
  isOfflineContent: Boolean,
  views: Number,
  createdBy: ObjectId,
  createdAt: Date,
  updatedAt: Date
}
```

### Contact Model
```javascript
{
  name: String,
  email: String,
  subject: String,
  message: String,
  status: String (new/read/resolved),
  createdAt: Date,
  updatedAt: Date
}
```

## 🌐 External API Integration

**NewsAPI** - Fetches latest news articles
- Endpoint: `https://newsapi.org/v2/everything`
- Free API key included (change in production)
- Query-based search functionality
- Returns title, description, image, source, and URL

## 💡 Optional Enhancements

- Add categories for better content organization
- Implement admin dashboard for content management
- Add dark mode toggle (UI ready)
- Email notifications for saved articles
- Advanced analytics dashboard
- Article tagging system
- User follow/subscribe features
- Real-time notifications

## 🐛 Troubleshooting

### MongoDB Connection Error
```
Solution: Ensure MongoDB is running locally
mongod --dbpath /path/to/data
```

### CORS Error
```
Solution: Backend CORS is configured for localhost:3000
If frontend runs on different port, update backend server.js
```

### API Not Responding
```
Solution: Check backend server is running on port 5000
npm run dev (in backend folder)
```

### Blank Articles
```
Solution: Create sample articles via API POST request
or import seed data to MongoDB
```

## 📝 Sample API Requests

### Register User
```bash
curl -X POST http://localhost:5000/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "confirmPassword": "password123"
  }'
```

### Create Article
```bash
curl -X POST http://localhost:5000/api/articles \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "title": "Understanding Blockchain",
    "description": "A comprehensive guide to blockchain technology",
    "content": "Blockchain is a distributed ledger...",
    "category": "Technology",
    "imageUrl": "https://example.com/image.jpg"
  }'
```

### Submit Contact Form
```bash
curl -X POST http://localhost:5000/api/contacts \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Doe",
    "email": "jane@example.com",
    "subject": "Feature Request",
    "message": "Please add offline maps support"
  }'
```

## 🎓 Learning Outcomes

This project demonstrates:
- Full-stack MERN development
- RESTful API design principles
- JWT authentication & authorization
- MongoDB database design
- React hooks and Context API
- Responsive web design with Tailwind CSS
- Error handling and validation
- Third-party API integration
- Environment variable management

## 📄 License

MIT License - Feel free to use this project for learning and commercial purposes.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## 📞 Support

For questions or support, contact: support@internetbox.com

---

**Made with ❤️ for building resilient offline knowledge systems**