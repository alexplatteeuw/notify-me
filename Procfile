web bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
release: bin/rails db:migrate # run db:migrate after each deployment
