set :application, "blog"
set :repository,  "git://oldman/prjs/rails/blog"

 set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


#set :gateway,  'somegateway.'
set :user, 'roadt'
set :use_sudo, false

role :web, "venus"                          # Your HTTP server, Apache/etc
role :app,"venus"                         # This may be the same as your `Web` server
role :db,  "venus", :primary => true # This is where Rails migrations will run
#role :db, "oldman"
#role :web, "oldman"
#role :app, "oldman"

# if you want to clean up old releases on each deploy uncomment this:

after "deploy:restart", "deploy:cleanup"
after "deploy:upload",  "deploy:restart"

before 'deploy:migrate', 'deploy:dbcreate'
after  'deploy:update_code', 'deploy:bundle_gems'



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

before 'deploy:migrate', 'deploy:dbcreate'
after  'deploy:update_code', 'deploy:bundle_gems'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    stop
    start
   end

  task :start do ;
    run "cd #{current_path} && bundle exec thin  -C config/thin.yml start"
  end
  
  task :stop do 
        run "cd #{current_path} && bundle exec thin -C config/thin.yml stop"
  end

  task :bundle_gems do
    run "cd #{deploy_to}/current && bundle install"
  end

  task :info do
    run "echo #{current_path}"
  end
end

