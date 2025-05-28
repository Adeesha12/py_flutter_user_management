#!/bin/bash
set -e

# Default values (get from environment or use defaults)
host="${POSTGRES_HOST:-db}"
port="${POSTGRES_PORT:-5432}"
user="${POSTGRES_USER:-myuser}"
database="${POSTGRES_DB:-mydb}"
password="${POSTGRES_PASSWORD:-mypassword}"

echo "⏳ Waiting for PostgreSQL to be ready..."
echo "🔍 Connecting to: $user@$host:$port/$database"

# Wait for PostgreSQL to be ready
until PGPASSWORD="$password" psql -h "$host" -p "$port" -U "$user" -d "$database" -c '\q' 2>/dev/null; do
  echo "🔄 PostgreSQL is unavailable - sleeping"
  sleep 2
done

echo "✅ PostgreSQL is up and running!"

# Run Django migrations
echo "🔄 Running database migrations..."
uv run python manage.py migrate

echo "✅ Migrations completed successfully!"

# Execute the main command
echo "🚀 Starting application..."
exec "$@"