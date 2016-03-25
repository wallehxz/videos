set :branch, 'master'
set :rvm_ruby_version, '2.2.0'
set :rvm_type, :user
set :deploy_to, '/var/apps/JustingXX'
set :rvm_custom_path, '/usr/local/rvm'
set :rvm_roles, [:app, :web]

server 'root@45.78.50.104', port: 29321, roles: %w[web app db], primary: true
