#!/bin/bash

# Internet-in-a-Box Quick Start Script
# This script automates the setup process

echo "🚀 Internet-in-a-Box Quick Start Setup"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Check if Node.js is installed
echo -e "${BLUE}Step 1: Checking Node.js installation...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}⚠️  Node.js is not installed. Please install it from https://nodejs.org/${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Node.js $(node -v) is installed${NC}"
echo ""

# Step 2: Check if MongoDB is running
echo -e "${BLUE}Step 2: Checking MongoDB...${NC}"
if ! command -v mongod &> /dev/null && ! command -v mongo &> /dev/null; then
    echo -e "${YELLOW}⚠️  MongoDB is not installed. Please install it from https://www.mongodb.com/${NC}"
    exit 1
fi
echo -e "${GREEN}✓ MongoDB is installed${NC}"
echo ""

# Step 3: Create .env file in backend
echo -e "${BLUE}Step 3: Setting up Backend environment...${NC}"
if [ -d "backend" ]; then
    cd backend
    
    # Check if .env exists
    if [ ! -f ".env" ]; then
        echo "Creating .env file..."
        cat > .env << EOF
PORT=5000
MONGODB_URI=mongodb://127.0.0.1:27017/internet-in-a-box
JWT_SECRET=internet_in_a_box_secret_key_change_in_production
NEWS_API_KEY=9f38bb87f50e4d959a26f70bef38a36d
NODE_ENV=development
EOF
        echo -e "${GREEN}✓ .env file created${NC}"
    else
        echo -e "${YELLOW}ℹ️  .env file already exists${NC}"
    fi
    
    # Install dependencies
    if [ ! -d "node_modules" ]; then
        echo "Installing backend dependencies..."
        npm install
        echo -e "${GREEN}✓ Backend dependencies installed${NC}"
    else
        echo -e "${GREEN}✓ Backend dependencies already installed${NC}"
    fi
    
    cd ..
else
    echo -e "${YELLOW}⚠️  Backend folder not found${NC}"
fi
echo ""

# Step 4: Setup Frontend
echo -e "${BLUE}Step 4: Setting up Frontend...${NC}"
if [ -d "frontend" ]; then
    cd frontend
    
    # Install dependencies
    if [ ! -d "node_modules" ]; then
        echo "Installing frontend dependencies..."
        npm install
        echo -e "${GREEN}✓ Frontend dependencies installed${NC}"
    else
        echo -e "${GREEN}✓ Frontend dependencies already installed${NC}"
    fi
    
    cd ..
else
    echo -e "${YELLOW}⚠️  Frontend folder not found${NC}"
fi
echo ""

# Step 5: Summary
echo -e "${GREEN}======================================"
echo "✓ Setup Complete!"
echo "=====================================${NC}"
echo ""
echo -e "${BLUE}To start the application:${NC}"
echo ""
echo "1. Start MongoDB (if not running):"
echo "   - macOS: brew services start mongodb-community"
echo "   - Windows: mongod"
echo "   - Linux: sudo systemctl start mongod"
echo ""
echo "2. Start Backend (Terminal 1):"
echo "   cd backend"
echo "   npm start"
echo ""
echo "3. Start Frontend (Terminal 2):"
echo "   cd frontend"
echo "   npm start"
echo ""
echo -e "${YELLOW}Frontend will open at: http://localhost:3000${NC}"
echo -e "${YELLOW}Backend API at: http://localhost:5000${NC}"
echo ""
echo "🎉 Happy coding!"