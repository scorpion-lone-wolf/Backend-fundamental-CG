#!/bin/bash

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#  Get project name
read -p "Enter Project Name: " project_name

# Validate project name is empty or not
if [[ -z $project_name ]]; then
    echo -e "${RED}Error : Project name can't be empty.${NC}"
    exit 1
fi

# Does folder name already exist or not
if [ -d "$project_name" ]; then
    echo -e "${RED}Folder $project_name exists in the current directory.${NC}"
    exit 1
fi

# Create a Folder
echo -e "${BLUE}Creating project folder...${NC}"
mkdir $project_name
cd $project_name

echo -e "${BLUE}Initialize package.json...${NC}"
# Initialize npm (default prompts)
npm init -y

# Set Package.json to use ESM
echo -e "${BLUE}Setting type:"module" in package.json${NC}"
sed -i '' 's/"type": "commonjs"/"type": "module"/' package.json

# Install dependencies
echo -e "${BLUE}Installing dependencies...${NC}"
npm i express dotenv cors morgan

# Install dev dependencies
npm i -D nodemon

# Update package.json scripts
echo -e "${BLUE}Adding npm scripts...${NC}"
sed -i '' 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"start": "node src\/server.js",\n   "dev": "nodemon src\/server.js"/' package.json

# Creating folder structure
echo -e "${BLUE}Creating folder structure...${NC}"
mkdir -p src/{routes,controllers,middleware,config}
# Creatig .env file
touch .env


# Create http server
echo -e "${BLUE}Creating http server file...${NC}"

cat > src/server.js << 'EOL'
import express from "express";
import cors from "cors";

const app = express();
const PORT = 3000;

// Enable CORS
app.use(cors());

// Enable JSON and URL-encoded parsing
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Basic GET route
app.get("/", (req, res) => {
  res.send("Hello, Express with CORS and body parsing 🚀");
});

// Example POST route
app.post("/api/data", (req, res) => {
  res.json({ message: "Data received!", data: req.body });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
EOL

#  Add middleware file , routes file , git init

sleep 0.5
echo -e "${GREEN}Project setup completed!${NC}..."

echo "To start development server : "
echo "1. cd $project_name"
echo "2. npm run dev"

