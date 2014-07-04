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

set :keep_db_backups, 10

set :backup_path, "#{fetch(:deploy_to)}/backups"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end


namespace :resque do
  task :_restart do
    begin
      invoke "resque:restart"
    rescue
      invoke "resque:start"
    end
  end
end
after "deploy:restart", "resque:_restart"

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
	        	execute :kill, "$(cat tmp/pids/faye.pid) && rm tmp/pids/faye.pid"
	        end
	    end
	end
  end
  desc "Restart Faye"
  task :restart do
    begin
  	  invoke "faye:stop"  
  	  invoke "faye:start"  
    rescue
      on release_roles :all do
        if test "[ -e #{current_path}/tmp/pids/faye.pid ]"
          execute :rm, "#{current_path}/tmp/pids/faye.pid"
        end
      end
      invoke "faye:start"
    end
  end
end
after 'deploy:restart', 'faye:restart'

desc "Backup the database"
namespace :db do
  task :backup do
      on roles(:db) do |host|
          backup_path = "#{fetch(:deploy_to)}/backups"
          execute :mkdir, "-p #{backup_path}"
          basename = 'database'

          username, password, database, host = get_remote_database_config(fetch(:stage))
          debug "#{database}"

          filename = "#{basename}_#{fetch(:stage)}_#{database}_#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.sql.bz2"
          debug "We will backup to file: #{backup_path}/#{filename}"

          hostcmd = host.nil? ? '' : "-h #{host}" 
          execute :mysqldump, "-u #{username} --password='#{password}' --databases #{database} #{hostcmd} | bzip2 -9 > #{backup_path}/#{filename}"

          purge_old_backups "#{basename}", "#{backup_path}"
      end
  end

  def get_remote_database_config(db)      
      remote_config = capture("cat #{shared_path}/config/database.yml")
      database = YAML::load(remote_config)
      return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], 
          database["#{db}"]['host']    
  end
 
  def purge_old_backups(basename,backup_path)
    max_keep = fetch(:keep_db_backups, 5).to_i
    backup_files = capture("ls -t #{backup_path}/#{basename}*").split.reverse
    if max_keep >= backup_files.length
      info "No old database backups to clean up"
    else
      info "Keeping #{max_keep} of #{backup_files.length} database backups"
      delete_backups = (backup_files - backup_files.last(max_keep)).join(" ")
      execute :rm, "-rf #{delete_backups}"
    end
  end
  desc "Upload backup config files."
  task :upload_config do
    on roles(:app) do
      execute "mkdir -p #{fetch(:backup_path)}/models"
      upload! StringIO.new(File.read("config/backup/config.rb")), "#{fetch(:backup_path)}/config.rb"
      upload! StringIO.new(File.read("config/backup/models/db_backup.rb")), "#{fetch(:backup_path)}/models/db_backup.rb"
    end
  end

  desc "Upload cron schedule file."
  task :upload_cron do
    on roles(:app) do
      execute "mkdir -p #{fetch(:backup_path)}/config"
      execute "touch #{fetch(:backup_path)}/config/cron.log"
      upload! StringIO.new(File.read("config/backup/schedule.rb")), "#{fetch(:backup_path)}/config/schedule.rb"

      within "#{fetch(:backup_path)}" do
        # capistrano was unable to find the executable for whenever
        # without the path to rbenv shims set
        with path: "/home/#{fetch(:deploy_user)}/.rbenv/shims:$PATH" do
          puts capture :whenever
          puts capture :whenever, '--update-crontab'
        end
      end
    end
  end
end
before 'deploy:updating', 'db:backup'