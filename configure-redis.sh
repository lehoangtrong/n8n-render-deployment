#!/bin/bash

# This script helps configure Redis environment variables for n8n
# You'll need to run this after deploying on Render

echo "n8n Redis Configuration Helper"
echo "------------------------------"
echo "This script will help you configure Redis environment variables for your n8n deployment on Render."
echo ""

# Get Redis details from the user
read -p "Enter your Redis host (from Render dashboard): " redis_host
read -p "Enter your Redis port (default: 6379): " redis_port
redis_port=${redis_port:-6379}
read -s -p "Enter your Redis password (from Render dashboard): " redis_password
echo ""

echo ""
echo "Please add the following environment variables in your Render dashboard for the n8n service:"
echo ""
echo "QUEUE_BULL_REDIS_HOST=$redis_host"
echo "QUEUE_BULL_REDIS_PORT=$redis_port"
echo "QUEUE_BULL_REDIS_PASSWORD=$redis_password"
echo ""
echo "These values need to be set in the Environment section of your n8n web service in the Render dashboard."
echo "Once set, your n8n instance will be properly connected to Redis for queue mode operation."