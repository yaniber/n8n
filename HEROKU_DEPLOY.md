# Deploying n8n to Heroku

This repository includes a one-click deployment configuration for Heroku with PostgreSQL 15+ support, community nodes, AI features, and DigitalOcean Spaces integration for persistent storage.

## Quick Deploy

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/yaniber/n8n)

## What's Included

✅ **PostgreSQL 15+ Support** - Compatible with Heroku's latest PostgreSQL versions (15, 16, 17)
✅ **Community Nodes** - Pre-configured to install and manage community packages
✅ **AI Features** - LangChain and AI workflow capabilities enabled
✅ **Python Support** - Python execution in Code nodes for advanced workflows
✅ **DigitalOcean Spaces Integration** - Persistent binary data storage to prevent file loss on dyno restarts
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
   
   # DigitalOcean Spaces configuration (replace with your values)
   heroku config:set N8N_DEFAULT_BINARY_DATA_MODE=s3
   heroku config:set N8N_EXTERNAL_STORAGE_S3_HOST=nyc3.digitaloceanspaces.com
   heroku config:set N8N_EXTERNAL_STORAGE_S3_BUCKET_NAME=your-bucket-name
   heroku config:set N8N_EXTERNAL_STORAGE_S3_ACCESS_KEY=your-access-key
   heroku config:set N8N_EXTERNAL_STORAGE_S3_ACCESS_SECRET=your-secret-key
   heroku config:set N8N_EXTERNAL_STORAGE_S3_BUCKET_REGION=nyc3
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
- `N8N_DEFAULT_BINARY_DATA_MODE=s3` - Enables persistent storage via DigitalOcean Spaces
- DigitalOcean Spaces configuration for persistent binary data storage

## PostgreSQL Version Compatibility

This configuration uses PostgreSQL 15 by default, which is fully supported by Heroku. The database connection is automatically configured from Heroku's `DATABASE_URL` environment variable.

## DigitalOcean Spaces Configuration

The deployment includes built-in support for DigitalOcean Spaces to provide persistent binary data storage. This prevents file loss when Heroku dynos restart (which happens at least once daily).

### Required Configuration

During deployment, you'll need to provide:

1. **DigitalOcean Spaces Credentials:**
   - Create a DigitalOcean Spaces bucket in your preferred region
   - Generate API keys from DigitalOcean > API > Spaces Keys
   - Note your bucket name and region

2. **Environment Variables (automatically prompted during deployment):**
   - `N8N_EXTERNAL_STORAGE_S3_HOST` - Endpoint URL (e.g., `nyc3.digitaloceanspaces.com`)
   - `N8N_EXTERNAL_STORAGE_S3_BUCKET_NAME` - Your bucket name
   - `N8N_EXTERNAL_STORAGE_S3_ACCESS_KEY` - Spaces access key
   - `N8N_EXTERNAL_STORAGE_S3_ACCESS_SECRET` - Spaces secret key
   - `N8N_EXTERNAL_STORAGE_S3_BUCKET_REGION` - Region (e.g., `nyc3`)

### Benefits

- **File Persistence:** Binary data, uploaded files, and workflow attachments survive dyno restarts
- **Scalability:** No storage limits imposed by Heroku's ephemeral filesystem
- **Cost-Effective:** DigitalOcean Spaces pricing is competitive for file storage
- **S3 Compatible:** Uses standard S3 API for reliability and performance

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