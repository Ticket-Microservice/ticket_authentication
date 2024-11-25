#!/bin/sh

# Run migrations
echo "Running migrations..."
mix ecto.migrate

# Seed the database
echo "Seeding the database..."
mix run priv/repo/seeds.exs

echo "Finish migrating and seeding"
sleep 40

# Start the Phoenix server
exec mix phx.server