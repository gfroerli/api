#!/bin/bash
set -e

PG_HOST=db
PG_PORT=5432

echo "Wait for postgres server to be ready..."
while ! nc -q 1 $PG_HOST $PG_PORT </dev/null; do sleep 1; done

# Create temporary directories
mkdir -p tmp/pids

bin/rails db:migrate
bin/bundle exec puma -C config/puma.rb -b tcp://0.0.0.0:3000
