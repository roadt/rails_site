set :application, "blog"
set :repository,  "git://oldman/prjs/rails/blog"

 set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


#set :gateway,  'somegateway.'
set :user, 'roadt'
set :use_sudo, false

role :web, "venus"                          # Your HTTP server, Apache/etc
role :app, "venus"                          # This may be the same as your `Web` server
role :db,  "venus", :primary => true # This is where Rails migrations will run


# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

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



role :libs, 'venus'
role :files, 'oldman'

task :search_libs, :roles => :libs  do
  run 'ls -x1 /usr/lib/ |grep -i xml'
end

task :count_libs, roles => :libs  do
  run 'ls -x1 /usr/lib/ | wc -l '
end

task :show_free_space, :roles => :files do
  run "df -h /"
end

task :rubygems do
  run 'bundle'
end

after :bundle_gems, :deploy

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end

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

