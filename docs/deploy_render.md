
♦️chmod +x bin/render-build.sh

#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate

♦️render.yaml

services:
- type: web
  name: rails-react
  runtime: ruby
  plan: free
  buildCommand: ./bin/render-build.sh
  startCommand: bundle exec puma -C config/puma.rb
  envVars:
  - key: DATABASE_URL
    fromDatabase:
    name: rails-react-db
    property: connectionString

  - key: RAILS_MASTER_KEY
    sync: false

  - key: WEB_CONCURRENCY
    value: "2"

databases:
- name: rails-react-db
  plan: free