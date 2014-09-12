lock '3.2.1'

set :application, 'fallacymania'
#set :repo_url, "/home/baranov/work/RoRprojects/#{fetch(:application)}"


case fetch(:stage) #TODO: lazy eval in
  when :production
    load File.expand_path('../secrets_deploy.rb', __FILE__)
  when :staging
    load File.expand_path('../secrets2_deploy.rb', __FILE__)
end



set :log_level, :info
set :default_env, { database_url:  "mysql2://deploy:#{fetch(:dbpassword)}@localhost/#{fetch(:application)}_#{fetch(:stage)}" }

set :deploy_via,      :remote_cache


set :puma_init_active_record, true

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/home/deploy/fallacymania'

# Default value for :scm is :git
 set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
 set :log_level, :debug

# Default value for :pty is false
 set :pty, true

# Default value for :linked_files is []
 set :linked_files, %w{config/database.yml config/secrets.yml config/.env.staging config/.env.production}

# Default value for linked_dirs is []
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

#namespace :example do
#  desc "Just tesing env var"
#  task :example do
#
#  on roles(:app), in: :sequence, wait: 5 do
#    with data: :foo do
#    puts capture("env ")
#      end
#  end
#    end
#end

namespace :deploy do #TODO: passenger only. remove!

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
       execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
