web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default -q mailers -e production -c 3
scheduler: bundle exec clockwork config/clock.rb
release: bundle exec rails db:migrate
