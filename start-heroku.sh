#!/bin/bash

# Heroku startup script for n8n
# This script configures environment variables from Heroku's DATABASE_URL

set -e

echo "🚀 Starting n8n on Heroku..."

# Parse DATABASE_URL if available (Heroku PostgreSQL addon provides this)
if [ -n "$DATABASE_URL" ]; then
  echo "📊 Configuring PostgreSQL from DATABASE_URL..."
  
  # Extract database connection details from DATABASE_URL
  # DATABASE_URL format: postgres://user:password@host:port/database
  
  # Use Node.js to parse the URL properly
  eval $(node -e "
    const url = require('url');
    const dbUrl = url.parse(process.env.DATABASE_URL);
    const auth = dbUrl.auth.split(':');
    
    console.log('export DB_POSTGRESDB_HOST=' + dbUrl.hostname);
    console.log('export DB_POSTGRESDB_PORT=' + dbUrl.port);
    console.log('export DB_POSTGRESDB_USER=' + auth[0]);
    console.log('export DB_POSTGRESDB_PASSWORD=' + auth[1]);
    console.log('export DB_POSTGRESDB_DATABASE=' + dbUrl.pathname.substring(1));
  ")
  
  echo "✅ PostgreSQL configuration complete"
fi

# Configure n8n host and webhook URL from Heroku app URL
if [ -n "$HEROKU_APP_NAME" ]; then
  export N8N_HOST="${HEROKU_APP_NAME}.herokuapp.com"
  export N8N_EDITOR_BASE_URL="https://${HEROKU_APP_NAME}.herokuapp.com"
  export WEBHOOK_URL="https://${HEROKU_APP_NAME}.herokuapp.com"
  echo "🌐 Configured n8n URLs for Heroku app: ${HEROKU_APP_NAME}"
fi

# Set default encryption key if not provided (for new installations)
if [ -z "$N8N_ENCRYPTION_KEY" ]; then
  echo "⚠️  Warning: N8N_ENCRYPTION_KEY not set. Generating a random key."
  echo "   IMPORTANT: Save this key securely. All credentials will be lost if changed."
  export N8N_ENCRYPTION_KEY=$(openssl rand -hex 32)
  echo "🔐 Generated encryption key: $N8N_ENCRYPTION_KEY"
fi

# Ensure all required directories exist
mkdir -p ~/.n8n

echo "🏁 Starting n8n..."

# Start n8n from the CLI package
exec ./bin/n8n start