#!/bin/bash

CONTAINER_NAME="local-postgres-db"
POSTGRES_USER="local-postgres-db"
POSTGRES_PASSWORD="local-postgres-db"
POSTGRES_VOLUME="$HOME/.config/posgres-local"

# Function to create a Postgres database
create_postgres_database() {
    local database="$1"
    local user="$database"
    local pass="$database"
    echo "Creating database: $database"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "CREATE DATABASE $database;"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "CREATE USER $user WITH PASSWORD '$pass';"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "GRANT ALL PRIVILEGES ON DATABASE $database TO $user;"
    echo "[+] Database: $1"
    echo "[+] Username: $1"
    echo "[+] Password: $1"
}

# Function to delete a Postgres database
delete_postgres_database() {
    local database="\"$1\""
    echo "Deleting database: $database"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "DROP DATABASE IF EXISTS $database;"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "DROP USER IF EXISTS $database;"
    echo "Database deleted: $database"
}

# Function to list Postgres databases
list_postgres_databases() {
    echo "Listing Postgres databases:"
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER" -c "\l"
}

enter_database() {
    echo "Entering to $database database."
    docker exec -it "$CONTAINER_NAME" psql -U "$POSTGRES_USER"
}

timer_log() {
    local seconds=$1
    local message=$2
    while [ "$seconds" -gt 0 ]; do
        echo -n "$message $seconds seconds..."
        sleep 1
        seconds=$((seconds - 1))
        echo -ne "\r"
    done
    echo "$message: 0 seconds."
}

# Function to print script help
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -c <database>   Create a Postgres database"
    echo "  -d <database>   Delete a Postgres database"
    echo "  -l              List Postgres databases"
    echo "  -h              Print this help message"
}

# Function to check the database infrastucture. Create or start the container if needed
function check_database_infrastucture {
    # check docker service
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed or not in PATH"
        exit 1
    fi
    if ! docker info &> /dev/null; then
        echo "Docker is not running"
        exit 1
    fi
    
    echo "[*] Docker service OK"

    # check if container is created
    if ! docker ps -a --format '{{.Names}}' | grep -q $CONTAINER_NAME; then 
        
        echo "Creating container: $CONTAINER_NAME"
        mkdir -p "$POSTGRES_VOLUME"
        docker run -d --name $CONTAINER_NAME \
            -p 5432:5432 \
            -e POSTGRES_USER=$POSTGRES_USER \
            -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
            -v "$POSTGRES_VOLUME":/var/lib/postgresql/data \
            postgres
        echo "[*] Waiting 5 seconds for database to start..."
        sleep 5

    # check if container is running
    elif ! docker ps -f name=$CONTAINER_NAME --format '{{.Names}}' | grep -q $CONTAINER_NAME; then
        
        echo "Starting container: $CONTAINER_NAME"
        docker start "$CONTAINER_NAME"
        echo "[*] Waiting 5 seconds for database to start..."
        sleep 5
        # timer_log 5 "[*] Waiting for ready status database"

    fi
}

clear

while getopts "c:d:leh" option; do
    case $option in
        c) 
            check_database_infrastucture
            echo "[*] Create database."
            create_postgres_database "$OPTARG"
            ;;
        d) 
            check_database_infrastucture
            echo "[*] Delete database"
            delete_postgres_database "$OPTARG"
            ;;
        l)
            check_database_infrastucture
            echo "[*] List databases"
            list_postgres_databases
            ;;
        e)
            check_database_infrastucture
            echo "[*] Entering in database"
            enter_database
            ;;
        h)
            display_help
            ;;

        *)
            display_help
            ;;
    esac
done