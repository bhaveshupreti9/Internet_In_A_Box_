# Complete Installation & Troubleshooting Guide

## 📦 Complete Project File Structure

```
internet-in-a-box/
│
├── backend/
│   ├── models/
│   │   ├── User.js                 # User schema with password hashing
│   │   ├── Article.js              # Article schema with full-text search
│   │   └── Contact.js              # Contact form schema
│   │
│   ├── routes/
│   │   ├── userRoutes.js           # Auth & profile routes
│   │   ├── articleRoutes.js        # Article CRUD routes
│   │   └── contactRoutes.js        # Contact form routes
│   │
│   ├── controllers/
│   │   ├── userController.js       # User logic: register, login, save
│   │   ├── articleController.js    # Article logic: CRUD, search, external API
│   │   └── contactController.js    # Contact logic: submit, manage
│   │
│   ├── config/
│   │   └── db.js                   # MongoDB connection setup
│   │
│   ├── utils/
│   │   └── fetchExternalData.js    # NewsAPI integration
│   │
│   ├── server.js                   # Express app setup & middleware
│   ├── .env                        # Environment variables (create this)
│   ├── package.json                # Dependencies & scripts
│   └── README.md                   # Backend documentation
│
├── frontend/
│   ├── public/
│   │   └── index.html              # HTML entry point
│   │
│   ├── src/
│   │   ├── components/
│   │   │   ├── Navbar.jsx          # Navigation with auth
│   │   │   ├── Footer.jsx          # Footer component
│   │   │   ├── Loader.jsx          # Loading spinner
│   │   │   └── PrivateRoute.jsx    # Protected route wrapper
│   │   │
│   │   ├── pages/
│   │   │   ├── Home.jsx            # Landing page with features
│   │   │   ├── Explore.jsx         # Article browsing & search
│   │   │   ├── Saved.jsx           # Saved articles (protected)
│   │   │   ├── Contact.jsx         # Contact form
│   │   │   └── Login.jsx           # Auth modal (register/login)
│   │   │
│   │   ├── services/
│   │   │   ├── api.js              # Axios instance with interceptors
│   │   │   ├── authService.js      # Auth API calls
│   │   │   └── articleService.js   # Article API calls
│   │   │
│   │   ├── context/
│   │   │   └── AuthContext.jsx     # Global auth state management
│   │   │
│   │   ├── App.jsx                 # Main app component with routing
│   │   ├── main.jsx                # React entry point
│   │   └── index.css               # Global styles & animations
│   │
│   ├── tailwind.config.js          # Tailwind config with color scheme
│   ├── postcss.config.js           # PostCSS configuration
│   ├── vite.config.js              # Vite build configuration
│   ├── package.json                # Dependencies & scripts
│   └── README.md                   # Frontend documentation
│
├── .gitignore                      # Git ignore rules
├── README.md                       # Main project documentation
├── SETUP_GUIDE.md                  # Detailed setup instructions
├── ARCHITECTURE.md                 # System architecture & design
├── QUICK_START.sh                  # Automated setup script
├── .env.example                    # Environment variables template
└── INSTALLATION_GUIDE.md           # This file

```

## 🔧 Installation Steps (Detailed)

### Prerequisites Installation

#### 1. Install Node.js

**Windows:**
- Download from https://nodejs.org/
- Run installer
- Follow prompts
- Verify: `node -v` and `npm -v`

**macOS:**
```bash
# Using Homebrew
brew install node

# Or download from nodejs.org
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install nodejs npm
```

#### 2. Install MongoDB

**Windows:**
```
1. Download MongoDB Community from https://www.mongodb.com/try/download/community
2. Run installer (mongodb-windows-x86_64-*.msi)
3. Choose "Install MongoDB as a Service"
4. MongoDB starts automatically
5. Verify: mongosh or mongo shell
```

**macOS:**
```bash
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

**Linux (Ubuntu):**
```bash
# Import MongoDB GPG key
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Add MongoDB repository
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Install MongoDB
sudo apt update
sudo apt install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
```

### Backend Installation

```bash
# Navigate to backend directory
cd backend

# Install all dependencies
npm install

# Create .env file (copy from .env.example or create new)
cat > .env << EOF
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/internet-in-a-box
JWT_SECRET=your_super_secret_jwt_key_change_in_production
NEWS_API_KEY=9f38bb87f50e4d959a26f70bef38a36d
NODE_ENV=development
EOF

# Start backend server
npm start

# Expected output:
# ✅ Server running on http://localhost:5000
# ✅ MongoDB connected: 127.0.0.1
```

### Frontend Installation

```bash
# Open new terminal, navigate to frontend
cd frontend

# Install dependencies
npm install

# Start development server
npm start

# App will open at http://localhost:3000
```

## ✅ Verification Checklist

After installation, verify everything works:

```bash
# 1. Check Node.js
node -v        # Should show v14+
npm -v         # Should show v6+

# 2. Check MongoDB
mongosh         # Should connect to MongoDB

# 3. Check MongoDB data
db.admin.ping() # Should return { ok: 1 }

# 4. Backend health check
curl http://localhost:5000/api/health
# Should return: { status: 'Server is running', timestamp: '...' }

# 5. Frontend loads
# Open http://localhost:3000 in browser
# Should see the Internet-in-a-Box homepage
```

## 🚀 Running the Application

### Method 1: Separate Terminals (