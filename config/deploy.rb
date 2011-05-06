
set :application, "TODO"
set :repository,  "git@github.com:myrlund/todo.git"

set :scm, :git

role :web, "login.danseku.no"                          # Your HTTP server, Apache/etc
role :app, "login.danseku.no"                          # This may be the same as your `Web` server
role :db,  "login.danseku.no", :primary => true # This is where Rails migrations will run

ssh_options[:forward_agent] = true

set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_to, "/www/todo"
default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :dbfix do
    run "#{try_sudo} ln -s #{File.join(shared_path, 'config', 'database.yml')} #{File.join(current_path, 'config', 'database.yml')}"
  end
end

after "deploy:finalize_update", "deploy:dbfix"
