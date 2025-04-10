# n8n Deployment on Render with Supabase

This repository contains configuration for deploying n8n workflow automation platform on Render with Supabase as the database.

## Deployment Steps

### 1. Set up Supabase

1. Create a Supabase account if you don't have one already
2. Create a new project in Supabase
3. Once your project is created, go to the SQL Editor
4. Create a new schema for n8n (optional, you can use the default `public` schema)
5. Note down your database connection details:
   - Host: From your Supabase project dashboard
   - Port: 5432 (default)
   - Database: postgres (default)
   - User: postgres (default)
   - Password: From your Supabase project dashboard
   - Schema: public (or the one you created)

### 2. Deploy to Render

1. Fork or clone this repository to your GitHub account
2. Create a new Render account or sign in to your existing one
3. In the Render dashboard, click on "New" and select "Blueprint"
4. Connect your GitHub account if you haven't already
5. Select your forked repository
6. Render will detect the `render.yaml` file and create the services
7. Update the following environment variables:
   - `DB_POSTGRESDB_HOST`: Your Supabase host (e.g., `db.abcdefghijklm.supabase.co`)
   - `DB_POSTGRESDB_PASSWORD`: Your Supabase database password
8. Deploy the services

### 3. Connect to Redis

The `render.yaml` file includes a Redis service that will be automatically set up. Render will automatically set the environment variables for the Redis connection.

### 4. Access n8n

Once deployed, you can access n8n at the URL provided by Render.

## Configuration Options

### Queue Mode for Scalability

This deployment is configured to use Queue mode for better scalability. This allows multiple instances of n8n to run concurrently, with Redis serving as the message broker.

### Environment Variables

Here are the key environment variables used in this deployment:

- `DB_TYPE`: Set to `postgresdb` for Supabase (PostgreSQL) database
- `DB_POSTGRESDB_*`: Database connection details
- `EXECUTIONS_MODE`: Set to `queue` for better scalability
- `QUEUE_BULL_REDIS_*`: Redis connection details
- `N8N_ENCRYPTION_KEY`: Automatically generated for security
- `N8N_PORT`: Set to 10000 (Render will handle routing)
- `N8N_PROTOCOL`: Set to https (Render handles SSL/TLS)

## Maintenance and Data Pruning

For long-term maintenance, consider setting up execution data pruning to prevent database growth issues:

```
N8N_HIRING_DATA_PRUNING=true
N8N_EXECUTIONS_DATA_PRUNE_MAX_COUNT=1000
N8N_EXECUTIONS_DATA_PRUNE_TIMEOUT=3600
N8N_EXECUTIONS_DATA_MAX_AGE=168
```

Add these to the environment variables section in `render.yaml` if needed.

## Upgrading n8n

To upgrade n8n to a newer version, update the Dockerfile to reference the latest tag:

```
FROM n8nio/n8n:latest
```

Or specify a specific version:

```
FROM n8nio/n8n:0.225.0
```

Then redeploy in the Render dashboard.

## Production Considerations

For production deployments:
- Use a larger plan for Redis and the n8n service
- Consider using a disk (persistent volume) for file storage if needed
- Set up backup mechanisms for your Supabase database
- Configure authentication for your n8n instance