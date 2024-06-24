#!/bin/sh

# Function to wait for the database to be ready
wait_for_db() {
    echo "Waiting for the database to be ready..."

    # Loop until the database is reachable or timeout occurs
    timeout=60
    while ! nc -z db 5432 > /dev/null 2>&1; do
        sleep 1
        ((timeout--))
        if [ $timeout -eq 0 ]; then
            echo "Timeout waiting for the database."
            exit 1
        fi
    done

    echo "Database is up"
}

# Wait for the database
wait_for_db

# Apply database migrations
python manage.py migrate

# Start the Django development server
exec "$@"