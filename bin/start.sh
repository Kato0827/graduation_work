#!/bin/bash
bundle exec rails db:migrate
bundle exec rails server -p $PORT -b 0.0.0.0