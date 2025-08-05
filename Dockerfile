FROM n8nio/n8n:0.225.0

# Add PostgreSQL client for Supabase connection
RUN apk add --no-cache postgresql-client

# Set environment variables with placeholders (to be set in Render)
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=SUPABASE_HOST
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=postgres
ENV DB_POSTGRESDB_USER=postgres
ENV DB_POSTGRESDB_PASSWORD=SUPABASE_PASSWORD
ENV DB_POSTGRESDB_SCHEMA=public

# # Run in queue mode for better scalability
# ENV EXECUTIONS_MODE=queue
# ENV QUEUE_BULL_REDIS_HOST=REDIS_HOST
# ENV QUEUE_BULL_REDIS_PORT=6379
# ENV QUEUE_BULL_REDIS_PASSWORD=REDIS_PASSWORD

# Set n8n to run in production
ENV NODE_ENV=production
ENV N8N_PORT=10000

# Expose the port n8n is running on
EXPOSE 10000

# Start n8n
# CMD ["n8n", "start"]
CMD ["node", "--max-old-space-size=256", "/usr/local/lib/node_modules/n8n/bin/n8n", "start"]
