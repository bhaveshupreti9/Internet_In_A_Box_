# Internet-in-a-Box - Architecture & System Design

## 🏗️ System Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     CLIENT LAYER                             │
│  ┌──────────────────────────────────────────────────────┐   │
│  │         React Frontend (Port 3000)                   │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │   │
│  │  │ Components   │  │ Pages        │  │ Context  │  │   │
│  │  ├ Navbar       │  ├ Home         │  └─ Auth    │  │   │
│  │  ├ Footer       │  ├ Explore      │     Context │  │   │
│  │  ├ Loader       │  ├ Saved        │             │  │   │
│  │  └ PrivateRoute │  ├ Contact      │             │  │   │
│  │                 │  └ Login        │             │  │   │
│  └──────────────────────────────────────────────────────┘   │
│              ↓ (Axios HTTP Requests)                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  API GATEWAY LAYER                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │     Express.js Server (Port 5000)                    │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌────────────┐  │   │
│  │  │ User Routes │  │Article Route│  │ Contact   │  │   │
│  │  ├ /register   │  ├ /articles    │  │ Routes    │  │   │
│  │  ├ /login      │  ├ /external    │  └────────────┘  │   │
│  │  ├ /profile    │  └ /search      │                  │   │
│  │  └ /save-art   │                 │                  │   │
│  └──────────────────────────────────────────────────────┘   │
│         ↓ (JWT Auth) ↓ (Middleware) ↓ (Validation)         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  BUSINESS LOGIC LAYER                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Controllers & Services                             │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌───────────┐ │   │
│  │  │ User Control │  │Article Ctrl  │  │ Contact  │ │   │
│  │  │- register()  │  │- getAll()    │  │ Ctrl     │ │   │
│  │  │- login()     │  │- search()    │  │- submit()│ │   │
│  │  │- saveArticle │  │- create()    │  └───────────┘ │   │
│  │  └──────────────┘  └──────────────┘                │   │
│  │                                                      │   │
│  │  ┌─────────────────────────────────────────────┐  │   │
│  │  │  Utilities & External Services              │  │   │
│  │  ├ Password Hashing (Bcrypt)                   │  │   │
│  │  ├ JWT Token Generation                        │  │   │
│  │  ├ External API Calls (NewsAPI)                │  │   │
│  │  └ Error Handling & Validation                 │  │   │
│  └──────────────────────────────────────────────────────┘   │
│         ↓ (Query) ↓ (Insert) ↓ (Update) ↓ (Delete)         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    DATA LAYER                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │      MongoDB Database                               │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌───────────┐ │   │
│  │  │ Users        │  │ Articles     │  │ Contacts  │ │   │
│  │  │ Collection   │  │ Collection   │  │ Collection│ │   │
│  │  ├ name         │  ├ title        │  ├ name      │ │   │
│  │  ├ email        │  ├ description  │  ├ email     │ │   │
│  │  ├ password     │  ├ content      │  ├ subject   │ │   │
│  │  ├ role         │  ├ category     │  ├ message   │ │   │
│  │  ├ savedArticles│  ├ views        │  ├ status    │ │   │
│  │  └ timestamps   │  └ timestamps   │  └ timestamps│ │   │
│  └──────────────────────────────────────────────────────┘   │
│         ↓ (Mongoose Indexes) ↓ (Validation Schemas)        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                 EXTERNAL SERVICES                            │
│  ├ NewsAPI (Latest Article Fetching)                        │
│  ├ JWT Token Service                                        │
│  ├ Bcrypt Password Hashing                                  │
│  └ HTTP Client (Axios)                                      │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow Diagrams

### User Registration Flow
```
User Input (Form)
    ↓
Frontend Validation
    ↓
Axios POST /api/users/register
    ↓
Backend Route Handler
    ↓
Validation Middleware (email unique, password match)
    ↓
Controller Logic
    ├ Hash password with Bcrypt
    ├ Create user document
    └ Generate JWT token
    ↓
Save to MongoDB
    ↓
Return JSON { token, user }
    ↓
Frontend Stores Token in localStorage
    ↓
Update Auth Context
    ↓
Redirect to Home Page
```

### Article Search Flow
```
User Search Input
    ↓
Frontend onChange Event
    ↓
Axios GET /api/articles?search=query&category=tech
    ↓
Backend Route Handler
    ↓
Build MongoDB Filter Query
    ├ $text: { $search: "query" }
    └ category: "Technology"
    ↓
Execute Aggregation Pipeline
    ↓
Return Matching Articles
    ↓
Frontend Receives JSON Array
    ↓
Update State (setArticles)
    ↓
Re-render Article Grid
    ↓
Display Results to User
```

### Save Article Flow
```
User Clicks Bookmark Icon
    ↓
Check if Authenticated
    ├ No → Redirect to Login
    └ Yes → Continue
    ↓
Axios POST /api/users/save-article
    ├ Headers: Authorization: Bearer {token}
    └ Body: { articleId }
    ↓
Backend JWT Middleware
    ├ Verify token
    └ Extract user ID
    ↓
Controller Logic
    ├ Find user by ID
    ├ Check if article already saved
    └ Add to savedArticles array
    ↓
Save to MongoDB
    ↓
Return Success Message
    ↓
Frontend Updates UI (bookmark filled)
```

### External News Fetch Flow
```
User Clicks "Latest News" Tab
    ↓
Frontend Loads State
    ↓
useEffect Trigger
    ↓
Axios GET /api/articles/external?query=technology
    ↓
Backend fetchExternalArticles Controller
    ↓
Axios GET https://newsapi.org/v2/everything
    ├ Params: q, sortBy, language, pageSize
    └ Headers: apiKey
    ↓
NewsAPI Returns JSON Articles
    ↓
Transform & Map Data
    ├ Extract title, description, content
    ├ Get image URLs
    └ Add external link
    ↓
Return Transformed Array
    ↓
Frontend Receives Data
    ↓
setExternalArticles(data)
    ↓
Render Card Grid with Articles
```

## 📊 Database Schema & Relationships

### User Collection
```javascript
{
  _id: ObjectId,
  name: String,                    // User's full name
  email: String,                   // Unique email address
  password: String,                // Hashed with Bcrypt
  role: String,                    // "user" or "admin"
  savedArticles: [ObjectId],       // References to Article documents
  createdAt: Date,                 // Auto-generated timestamp
  updatedAt: Date                  // Auto-updated timestamp
}
```

### Article Collection
```javascript
{
  _id: ObjectId,
  title: String,                   // Article title (indexed for search)
  description: String,             // Short description (indexed)
  content: String,                 // Full article content (indexed)
  category: String,                // Tech, Science, History, etc.
  source: String,                  // Where article came from
  externalUrl: String,             // Link to original source
  imageUrl: String,                // Cover image URL
  isOfflineContent: Boolean,        // true for DB articles, false for external
  views: Number,                   // Counter for page views
  createdBy: ObjectId,             // Reference to User document
  createdAt: Date,                 // Auto-generated timestamp
  updatedAt: Date                  // Auto-updated timestamp
}

// Indexes
- title: text
- description: text
- content: text
- category: 1
- createdAt: -1
```

### Contact Collection
```javascript
{
  _id: ObjectId,
  name: String,                    // Visitor's name
  email: String,                   // Visitor's email
  subject: String,                 // Message subject
  message: String,                 // Message body
  status: String,                  // "new", "read", or "resolved"
  createdAt: Date,                 // Auto-generated timestamp
  updatedAt: Date                  // Auto-updated timestamp
}

// Indexes
- createdAt: -1
- status: 1
```

### Relationships
```
User (1) ──── (Many) Articles
  └── has many savedArticles
      └── references Article IDs

User (1) ──── (Many) Articles (created)
  └── createdBy field

Article ──── User (creator)
  └── createdBy field references User._id

Contact (No direct relationships)
  └── Stores visitor inquiries independently
```

## 🔐 Security Architecture

### Authentication Flow
```
1. User Registration
   └─ Password → Bcrypt Hash → Store in DB

2. User Login
   ├─ Email lookup in DB
   ├─ Compare input password with hashed password
   └─ If match → Generate JWT Token

3. JWT Token Structure
   ├─ Header: { alg: "HS256", typ: "JWT" }
   ├─ Payload: { id: userId, iat: timestamp }
   └─ Signature: HMAC(header.payload, secret)

4. Authenticated Request
   ├─ Client sends: Authorization: Bearer {token}
   ├─ Server verifies signature with secret
   ├─ Extract user ID from payload
   └─ Execute protected route

5. Token Expiration
   ├─ Set to 7 days
   └─ User must re-login after expiration

6. Protected Routes
   ├─ PrivateRoute wrapper checks authentication
   ├─ Redirect to login if no token
   └─ Render component if authenticated
```

### Password Security
```
Registration:
  Input: "myPassword123"
           ↓
  Bcrypt: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36DRZlG6
           ↓
  Store in DB

Login Verification:
  Input: "myPassword123"
  Hash:  $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36DRZlG6
           ↓
  Bcrypt Compare → Match or Fail
```

## 🔄 API Communication Protocol

### Request Structure
```
POST /api/articles HTTP/1.1
Host: localhost:5000
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

{
  "title": "Article Title",
  "description": "Description",
  "content": "Full content",
  "category": "Technology"
}
```

### Response Structure
```json
{
  "message": "Success message",
  "data": {
    "_id": "507f1f77bcf86cd799439011",
    "title": "Article Title",
    "createdAt": "2024-01-15T10:30:00.000Z"
  },
  "error": null,
  "statusCode": 201
}
```

### Error Handling
```json
{
  "message": "Error description",
  "error": "Validation failed",
  "statusCode": 400
}
```

## 🎯 API Endpoint Categories

### User Management (/api/users)
| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | /register | No | Create new user account |
| POST | /login | No | Authenticate user |
| GET | /profile | Yes | Get user profile & saved articles |
| POST | /save-article | Yes | Save article to collection |
| POST | /remove-saved-article | Yes | Remove saved article |

### Article Management (/api/articles)
| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| GET | / | No | Get all/filtered articles |
| GET | /:id | No | Get single article (increment views) |
| GET | /external | No | Fetch from external API |
| POST | / | Yes | Create new article |
| PUT | /:id | Yes | Update article |
| DELETE | /:id | Yes | Delete article |

### Contact Management (/api/contacts)
| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | / | No | Submit contact form |
| GET | / | Admin | Get all contacts |
| GET | /:id | Admin | Get single contact |
| PUT | /:id | Admin | Update contact status |

## ⚙️ Middleware Stack

### Request Processing Order
```
1. CORS Middleware
   └─ Enable cross-origin requests

2. Body Parser Middleware
   ├─ application/json
   └─ application/x-www-form-urlencoded

3. Route Handler
   └─ Match URL to route

4. Authentication Middleware (if protected)
   ├─ Extract token from headers
   ├─ Verify JWT signature
   └─ Attach user to request

5. Validation Middleware (if needed)
   ├─ Validate request body
   └─ Sanitize inputs

6. Controller Logic
   ├─ Business logic
   ├─ Database operations
   └─ Response preparation

7. Error Handling Middleware
   ├─ Catch errors
   ├─ Log errors
   └─ Send error response
```

## 🗄️ Database Optimization

### Indexing Strategy
```javascript
// User Collection
db.users.createIndex({ email: 1 }, { unique: true })

// Article Collection
db.articles.createIndex({ title: "text", description: "text", content: "text" })
db.articles.createIndex({ category: 1 })
db.articles.createIndex({ createdAt: -1 })
db.articles.createIndex({ views: -1 })

// Contact Collection
db.contacts.createIndex({ createdAt: -1 })
db.contacts.createIndex({ status: 1 })
```

### Query Optimization
```javascript
// Avoid N+1 queries with populate
db.users.findById(id).populate('savedArticles')

// Limit results for pagination
db.articles.find().limit(10).skip(0)

// Use projections to select only needed fields
db.articles.find({}, { title: 1, description: 1, views: 1 })
```

## 🚀 Performance Considerations

### Frontend Optimization
- Lazy loading for images
- Code splitting with React Router
- Memoization for expensive renders
- Debouncing search inputs
- Caching API responses

### Backend Optimization
- Database indexing on frequently queried fields
- Pagination for large result sets
- Compression middleware (gzip)
- Rate limiting for API endpoints
- Connection pooling for database

### Caching Strategy
```
Frontend:
- localStorage for user tokens
- State management for UI state
- Browser cache for static assets

Backend:
- Redis for session storage (optional)
- HTTP cache headers
- Aggregation pipelines for complex queries
```

## 📈 Scalability Architecture

### Horizontal Scaling
```
Load Balancer
├─ Backend Server 1 (Port 5000)
├─ Backend Server 2 (Port 5001)
├─ Backend Server 3 (Port 5002)
└─ Shared MongoDB Instance
    └─ Replica Set for failover
```

### Database Sharding
```
Primary Shard (A-M)
├─ Users A-M
├─ Articles A-M
└─ Contacts A-M

Secondary Shard (N-Z)
├─ Users N-Z
├─ Articles N-Z
└─ Contacts N-Z
```

## 🔄 Deployment Architecture

### Development Environment
```
Local Machine
├─ Frontend: http://localhost:3000
├─ Backend: http://localhost:5000
└─ MongoDB: mongodb://127.0.0.1:27017
```

### Production Environment
```
CDN (Frontend)
├─ Vercel / Netlify / GitHub Pages
└─ React build artifacts

Cloud Server (Backend)
├─ Heroku / Railway / AWS EC2
├─ Environment variables
└─ Monitoring & Logging

Managed Database
├─ MongoDB Atlas
├─ Automated backups
└─ Replica sets
```

## 🧪 Testing Strategy

### Unit Tests
```
- Controller functions
- Utility functions
- Validation logic
- Password hashing
```

### Integration Tests
```
- API endpoints
- Database operations
- Authentication flow
- Third-party API calls
```

### E2E Tests
```
- User registration flow
- Login/logout
- Article search
- Save/remove articles
- Contact form submission
```

---

**Architecture Version 1.0 - Last Updated: 2024**