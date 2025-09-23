# Deploying n8n to Heroku

This repository includes a one-click deployment configuration for Heroku with PostgreSQL 15+ support, community nodes, and AI features enabled.

## Quick Deploy

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/yaniber/n8n)

## What's Included

✅ **PostgreSQL 15+ Support** - Compatible with Heroku's latest PostgreSQL versions (15, 16, 17)
✅ **Community Nodes** - Pre-configured to install and manage community packages
✅ **AI Features** - LangChain and AI workflow capabilities enabled
✅ **Python Support** - Python execution in Code nodes for advanced workflows
✅ **Production Ready** - Optimized configuration for Heroku deployment

## Manual Deployment

If you prefer to deploy manually:

1. **Create a Heroku app:**
   ```bash
   heroku create your-n8n-app
   ```

2. **Add PostgreSQL addon:**
   ```bash
   heroku addons:create heroku-postgresql:essential-0 --version=15
   ```

3. **Set environment variables:**
   ```bash
   heroku config:set N8N_ENCRYPTION_KEY=$(openssl rand -hex 32)
   heroku config:set NODE_ENV=production
   heroku config:set N8N_COMMUNITY_PACKAGES_ENABLED=true
   heroku config:set N8N_AI_ENABLED=true
   ```

4. **Deploy:**
   ```bash
   git push heroku main
   ```

## Environment Variables

The deployment automatically configures essential environment variables. Key variables include:

- `N8N_ENCRYPTION_KEY` - Critical for securing credentials (auto-generated)
- `DB_TYPE=postgresdb` - Uses PostgreSQL database
- `N8N_COMMUNITY_PACKAGES_ENABLED=true` - Enables community nodes
- `N8N_AI_ENABLED=true` - Enables AI features and LangChain support
- `N8N_PYTHON_ENABLED=true` - Enables Python in Code nodes

## PostgreSQL Version Compatibility

This configuration uses PostgreSQL 15 by default, which is fully supported by Heroku. The database connection is automatically configured from Heroku's `DATABASE_URL` environment variable.

## Community Nodes

Community nodes are fully enabled and can be installed through the n8n interface or by setting additional environment variables. The configuration allows both verified and unverified packages.

## AI and LangChain Features

AI features are enabled by default, allowing you to:
- Build AI agent workflows
- Use LangChain nodes and integrations
- Execute Python code for advanced AI processing
- Access community AI nodes and workflows

## Production Considerations

For production use, consider:
- Upgrading to `heroku-postgresql:standard-0` or higher
- Scaling to `standard-1x` or larger dyno sizes
- Setting up proper monitoring and logging
- Backing up your encryption key securely

## Support

- [n8n Documentation](https://docs.n8n.io)
- [Community Forum](https://community.n8n.io)
- [Heroku PostgreSQL Documentation](https://devcenter.heroku.com/articles/heroku-postgresql)