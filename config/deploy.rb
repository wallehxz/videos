set :application, 'koogle'
set :scm, :git
set :repo_url, 'git@github.com:kooogle/videos.git'
set :rails_env, 'production'
set :ssh_options, { keys: %w{~/.ssh/id_rsa}, forward_agent: true, auth_methods: %w(publickey) }
set :format, :pretty
set :log_level, :debug
set :keep_assets, 2
set :keep_releases, 3

SSHKit.config.command_map[:rake] = 'bundle exec rake'
SSHKit.config.command_map[:rails] = 'bundle exec rails'


#Puma Server
set :puma_init_active_record, true

set :linked_files, %w{
  config/database.yml
  config/secrets.yml
  config/settings.rb

}

set :linked_dirs, %w{
  log
  tmp/cache
  tmp/pids
  tmp/sockets
  public/uploads
  public/logger
}

namespace :deploy do

  desc '管理数据库配置文件'
  task :setup_config do
    on roles(:web) do |host|
      execute :mkdir, "-p #{deploy_to}/shared/config"
      upload! 'config/database.yml.sample', "#{deploy_to}/shared/config/database.yml"
      upload! 'config/secrets.yml.sample', "#{deploy_to}/shared/config/secrets.yml"
      upload! 'config/settings.rb.sample', "#{deploy_to}/shared/config/settings.rb"
    end
  end

  desc '重启服务'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc '将配置数据写入数据库'
  task :seed do
    on roles(fetch(:migration_role)) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  after 'deploy:migrate', 'deploy:restart'

  # task :stop do
  #   run "cd #{deploy_to}/current && ./crmd.sh stop"
  # end
end
