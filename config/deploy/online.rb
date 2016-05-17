set :branch, 'master'
set :rvm_ruby_version, '2.2.2'
set :rvm_type, :user
set :deploy_to, '/var/www/web/videos'
set :rvm_custom_path, '/usr/local/rvm'
set :rvm_roles, [:app, :web]

server 'www-data@23.83.252.29', port: 22, roles: %w[web app db], primary: true
