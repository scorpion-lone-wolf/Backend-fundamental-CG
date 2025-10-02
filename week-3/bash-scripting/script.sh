#!/bin/bash

#########################################
# BASH SCRIPT CHEATSHEET / REFERENCE
#########################################

# -----------------------------
# ✅ VARIABLES
# -----------------------------
# Lowercase for regular variables, UPPERCASE for environment variables
# Example:
# name="Rahul"
# echo "Welcome, $name!"

# -----------------------------
# ✅ IF-ELSE STATEMENT
# -----------------------------
# name="Backend"
# if [ "$name" == "Rahul" ]; then
#     echo "You are Rahul!"
# else
#     echo "You are not Rahul!"
# fi

# ------------------------------
# ✅ SINGLE QUOTES VS DOUBLE QUOTES
# -----------------------------
# Double quotes allow variable interpolation
# name="Backend"
# echo "Welcome, $name"   # Output: Welcome, Backend
# echo 'Welcome, $name'   # Output: Welcome, $name

# -----------------------------
# ✅ FOR LOOPS
# -----------------------------

# Loop through fixed numbers
# for num in 1 2 3 4 5; do
#     echo $num
#     sleep 0.5  # Pause for 0.5 seconds
# done

# Loop through a range of numbers
# for num in {1..100}; do
#     echo $num
# done

# Loop through array/list
# languages=("java" "golang" "javascript")
# for item in "${languages[@]}"; do
#     echo $item
# done

# Loop through array using indices
# for ((i=0; i<"${#languages[@]}"; i++)); do
#     echo "${languages[i]}"
# done

# -----------------------------
# ✅ PROGRAM ARGUMENTS
# -----------------------------
# Access positional arguments
# echo "First argument: $1"
# echo "Second argument: $2"

# -----------------------------
# ✅ NAMED ARGUMENTS (OPTIONS)
# -----------------------------
# while getopts ":u:p:" opt; do
#     case $opt in
#         u) username="$OPTARG";;
#         p) password="$OPTARG";;
#         \?) echo "Invalid option"; exit 1;;
#     esac
# done
# echo "Username: $username"
# echo "Password: $password"

# -----------------------------
# ✅ PROMPTING USER INPUT
# -----------------------------
# YELLOW='\033[0;33m'   # Color variable
# NC='\033[0m'           # No color / reset
# echo -n "Enter your name: "
# read name
# echo -e "${YELLOW}Welcome: $name${NC}"

# read -sp "Enter your password: " password
# echo
# echo "Your password: $password"

# -----------------------------
# ✅ CREATING FILES
# -----------------------------
# Write single line to a file
# echo "Welcome to backend cohort" > welcome.txt
# Display file contents
# cat welcome.txt

# Here-document for multi-line text
# cat > welcome.txt << EOL
# Welcome to backend cohort.
# Cohort started on Feb 8th.
# We are enjoying.
# EOL

# -----------------------------
# ✅ CREATING DIRECTORIES
# -----------------------------
# mkdir -p {hello,welcome,nice,config}

# -----------------------------
# ✅ STRING OPERATIONS
# -----------------------------
# Create example file
# echo "Hello World" > example.txt

# Stream editor (sed) to search & replace
# Replace 'World' with 'Backend' in example.txt
# /g = replace all the occurrence else only first occurrence in each line and proceed to next line for replacement
# For MacOS:
# sed -i '' 's/World/Backend/g' example.txt
# For Linux:
# sed -i 's/World/Backend/g' example.txt
