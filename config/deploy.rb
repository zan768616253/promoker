# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'promoker'
set :repo_url, 'git@bitbucket.org:linyaoyi/promoker.git'
set :branch, ENV['rev'] || "master"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/u/apps/#{fetch(:application)}"

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

after "deploy:restart", "resque:restart"

namespace :faye do
  desc "See current faye status"
  task :status do
  	on release_roles :all do
	    if test "[ -e #{current_path}/tmp/pids/faye.pid ]"
	        within current_path do
	          file = capture(:ls, "-1 tmp/pids/faye.pid")
	          info capture(:ps, "-f -p $(cat #{file.chomp}) | sed -n 2p")
	        end
	    end
	end
  end
  desc "Start Faye"
  task :start do
  	on release_roles :all do
	  	within current_path do
	    	execute :bundle, "exec rackup faye.ru -s thin -E production -D --pid tmp/pids/faye.pid"
	    end
	end
  end
  desc "Stop Faye"
  task :stop do
  	on release_roles :all do
	  	if test "[ -e #{current_path}/tmp/pids/faye.pid ]"
	        within current_path do
	        	execute :kill, "$(cat tmp/pids/faye.pid) > /dev/null 2>&1 && rm tmp/pids/faye.pid"
	        end
	    end
	end
  end
  desc "Restart Faye"
  task :restart do
  	invoke "faye:stop"  
  	invoke "faye:start"  
  end
end
after 'deploy:restart', 'faye:restart'