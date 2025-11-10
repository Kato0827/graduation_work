set -e

echo "Starting database migration..."
bundle exec rails db:migrate

echo "Starting Rails server..."
bundle exec rails server -p $PORT -b 0.0.0.0
