set :application, "blog"


# Source control system.
 set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "roadt@venus:/repos/github/roadt/rails_blog"
set :deploy_via, :remote_cache
# set :user, 'deployer'
# set :scm_passphrase "p@ss"
set :branch, "master"


#set :gateway,  'somegateway.'
set :user, 'roadt'
set :use_sudo, false
set :rake,      "bundle exec rake"
role :web, "venus"                          # Your HTTP server, Apache/etc
role :app,"venus"                         # This may be the same as your `Web` server
role :db,  "venus", :primary => true # This is where Rails migrations will run
#role :db, "oldman"
#role :web, "oldman"
#role :app, "oldman"


# blog system work with no  precompile , remove precompile
callback = callbacks[:after].find{|c| c.source == "deploy:assets:precompile" }
callbacks[:after].delete(callback)
#after 'deploy:update_code', 'deploy:assets:precompile' unless fetch(:skip_assets, false)

# if you want to clean up old releases on each deploy uncomment this:

after  'deploy:update_code', 'deploy:bundle_gems'


before 'deploy:migrate', 'deploy:dbcreate'

after "deploy:restart", "deploy:cleanup"
after "deploy:upload",  "deploy:restart2"




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

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    stop
    start
   end

  task :start do ;
    run "cd #{current_path}  &&  bundle exec thin  -C config/thin.yml start"
  end
  
  task :stop do 
        run "cd #{current_path} && bundle exec thin -C config/thin.yml stop"
  end

  task :bundle_gems do
    run "cd #{release_path} && bundle install"
  end

  task :info do
    run "echo #{current_path}"
  end

  task :dbcreate, :roles =>:db do
        run "cd #{release_path} && #{rake} db:create"
  end

  task :migrate2, :roles =>:db do 
    run "cd #{current_path} && #{rake} RAILS_ENV=production db:migrate"
  end
  
  task :updateapp2 do 
    transaction do 
      update_code
      create_symlink
    end
    migrate2
    restart
  end
  
  task :update2 do 
    updateapp2
    restart
  end

  task :bundle do
    run "cd #{current_path} && bundle install"
  end

  task :restart2 do
      run "cd #{current_path}  &&  bundle exec thin  -C config/thin.yml restart"
  end
end

