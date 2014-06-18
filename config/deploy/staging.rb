set :rails_env, "staging"
server 'staging.promoker.com', user: 'deploy', roles: %w{web app db}

