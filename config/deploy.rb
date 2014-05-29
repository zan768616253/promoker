# coding: utf-8
require "bundler/capistrano"
require "rvm/capistrano"

default_run_options[:pty] = true

set :rvm_ruby_string, 'ruby-2.1.1'
set :rvm_type, :user
set :use_sudo, false

set :application, "promoker"
set :deploy_to, "/data/www/#{application}"
set :keep_releases, 5

set :scm, :git
set :repository, "git://github.com/yaoyi/promoker.git"
set :deploy_via, :remote_cache 
set :copy_exclude, [".git", ".DS_Store"]
set :user, "deployer"

set :branch,  ENV['rev'] || 'master'
set :target, ENV['target'] || 'vagrant'
set :rails_env, "#{target}" || 'vagrant'
set :config_path, "#{release_path}/config/server/#{rails_env}"

set :run_migrations, ENV['migrate'] == 'no' ? false : true

set :git_shallow_clone, 1


# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "promoker.com"                          # Your HTTP server, Apache/etc
role :app, "promoker.com"                          # This may be the same as your `Web` server
role :db,  "promoker.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end