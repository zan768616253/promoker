# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'promoker'
set :repo_url, 'git@bitbucket.org:linyaoyi/promoker.git'
set :branch, ENV['rev'] || "master"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/u/apps/'#{fetch(:application)}'"

# Use agent forwarding for SSH so you can deploy with the SSH key on your workstation.
set :ssh_options, {
  forward_agent: true
}

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: "/opt/rbenv/shims:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end

role :resque_worker, "staging.promoker.com"
role :resque_scheduler, "staging.promoker.com"

set :workers, { "confirm_email" => 1 }

after "deploy:restart", "resque:restart"