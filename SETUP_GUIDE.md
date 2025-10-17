# Internet-in-a-Box - Complete Setup Guide

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v14 or higher) - [Download](https://nodejs.org/)
- **MongoDB** (Community Edition) - [Download](https://www.mongodb.com/try/download/community)
- **Git** - [Download](https://git-scm.com/)
- **Code Editor** - VS Code recommended

## 🎬 Step-by-Step Setup

### Step 1: MongoDB Installation & Setup

#### On Windows
1. Download MongoDB Community Edition from https://www.mongodb.com/try/download/community
2. Run the installer
3. Choose "Install MongoDB as a Service"
4. MongoDB will start automatically

Test connection:
```bash
mongo
```

#### On macOS
```bash
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

#### On Linux (Ubuntu)
```bash
sudo apt-get install -y mongodb
sudo systemctl start mongodb
```

Verify MongoDB is running:
```bash
mongosh
```

### Step 2: Backend Setup

1. **Navigate to backend folder**
```bash
cd backend
```

2. **Install dependencies**
```bash
npm install
```

3. **Create `.env` file** in backend folder:
```
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/internet-in-a-box
JWT_SECRET=your_super_secret_jwt_key_change_in_production
NEWS_API_KEY=9f38bb87f50e4d959a26f70bef38a36d
NODE_ENV=development
```

4. **Start backend server**
```bash
npm start
```

You should see:
```
✅ Server running on http://localhost:5000
✅ MongoDB connected: 127.0.0.1
```

### Step 3: Frontend Setup

**Open a new terminal window** and navigate to frontend:

1. **Navigate to frontend folder**
```bash
cd frontend
```

2. **Install dependencies**
```bash
npm install
```

3. **Start development server**
```bash
npm start
```

The application will automatically open at `http://localhost:3000`

## ✅ Verification Checklist

After setup, verify everything is working:

- [ ] Backend server running at http://localhost:5000
- [ ] MongoDB connected successfully
- [ ] Frontend app running at http://localhost:3000
- [ ] Can navigate to home page
- [ ] Can access explore page and see articles
- [ ] Can navigate to contact page
- [ ] Can click login button
- [ ] Can register new account
- [ ] Can search and filter articles
- [ ] External news articles load

## 🧪 Testing the Application

### Test 1: Create User Account
1. Click "Login" in navbar
2. Switch to "Register" tab
3. Fill in: Name, Email, Password, Confirm Password
4. Click "Register"
5. Should redirect to home page and be logged in

### Test 2: Browse Offline Articles
1. Go to "Explore" page
2. Browse articles in the first tab
3. Use search box to find specific articles
4. Filter by category using dropdown

### Test 3: View External News
1. In "Explore" page, click "Latest News" tab
2. Should display recent news from NewsAPI
3. Click external link icon to read full article

### Test 4: Save Articles (Requires Login)
1. Make sure you're logged in
2. In "Explore" page, click bookmark icon on any article
3. Go to "Saved" page
4. Saved articles should appear
5. Click trash icon to remove

### Test 5: Contact Form
1. Go to "Contact" page
2. Fill in all fields
3. Click "Send Message"
4. Should see success message
5. Form should clear

## 🔧 Common Issues & Solutions

### Issue: MongoDB Connection Error
```
Error: connect ECONNREFUSED 127.0.0.1:27017
```
**Solution:**
- Ensure MongoDB is running: `mongod` (Windows) or `brew services start mongodb-community` (macOS)
- Check MongoDB URI in `.env` file
- Verify port 27017 is not blocked by firewall

### Issue: Port Already in Use
```
Error: listen EADDRINUSE: address already in use :::5000
```
**Solution:**
- Change PORT in `.env` file
- Or kill process: `lsof -ti:5000 | xargs kill -9` (macOS/Linux)

### Issue: CORS Error
```
Access to XMLHttpRequest blocked by CORS policy
```
**Solution:**
- Backend CORS is configured for localhost:3000
- If running on different port, update backend/server.js:
```javascript
app.use(cors({
  origin: 'http://localhost:YOUR_PORT'
}));
```

### Issue: Articles Not Loading
```
GET /api/articles returns empty array
```
**Solution:**
- Create sample articles via API POST request
- Or insert sample data directly in MongoDB:
```javascript
db.articles.insertMany([
  {
    title: "Offline Knowledge Guide",
    description: "Learn about offline systems",
    content: "Content here...",
    category: "Education",
    isOfflineContent: true
  }
])
```

### Issue: External News Not Loading
```
NewsAPI Error
```
**Solution:**
- Check internet connection
- Verify NEWS_API_KEY in `.env`
- API key might be exhausted (free tier has limits)
- Try different search query

### Issue: Login Not Working
```
Token not saved or login unsuccessful
```
**Solution:**
- Clear browser localStorage: Open DevTools → Application → Clear All
- Check backend is responding to login POST request
- Verify JWT_SECRET is set in `.env`

## 📁 File Structure Quick Reference

```
internet-in-a-box/
├── backend/
│   ├── server.js (Main server entry)
│   ├── .env (Create this file)
│   ├── config/db.js (Database setup)
│   ├── models/ (Data schemas)
│   ├── routes/ (API endpoints)
│   ├── controllers/ (Business logic)
│   └── package.json
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx (Main component)
│   │   ├── main.jsx (Entry point)
│   │   ├── pages/ (Page components)
│   │   ├── components/ (Reusable components)
│   │   └── services/ (API calls)
│   ├── package.json
│   └── vite.config.js
│
└── README.md (Project documentation)
```

## 🚀 Production Deployment

For production deployment (Heroku, AWS, etc.):

1. **Backend Environment Variables**
```
PORT=5000
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/database
JWT_SECRET=generate_strong_random_secret_key
NEWS_API_KEY=your_api_key
NODE_ENV=production
```

2. **Frontend Build**
```bash
cd frontend
npm run build
```

3. **Deploy Frontend** to Vercel, Netlify, or GitHub Pages
4. **Deploy Backend** to Heroku, Railway, or AWS

## 📚 Additional Resources

- [MongoDB Documentation](https://docs.mongodb.com/)
- [Express.js Guide](https://expressjs.com/)
- [React Documentation](https://react.dev/)
- [Tailwind CSS](https://tailwindcss.com/)
- [JWT Authentication](https://jwt.io/)
- [NewsAPI Documentation](https://newsapi.org/docs)

## 💬 Getting Help

If you encounter issues:

1. Check the error message carefully
2. Review the "Common Issues" section above
3. Check browser console (F12) for frontend errors
4. Check terminal for backend errors
5. Visit project documentation or open an issue

## 📝 Notes

- Default admin user: Create via register (all users start as regular users)
- JWT tokens expire after 7 days
- Articles are searchable by title, description, and content
- Contact form data is stored in MongoDB
- All passwords are hashed with Bcrypt
- Frontend runs on port 3000, Backend on port 5000

---

**Happy coding! 🎉**