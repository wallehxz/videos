set :branch, 'master'
set :deploy_to, '/home/www/web/tv'
set :rvm_type, :user
set :rvm_roles, [:web, :app]
set :rvm_custom_path, '/usr/local/rvm'
set :rvm_ruby_version, '2.0.0'

server 'www@52.193.68.82', port: 22, roles: %w[web app db], primary: true