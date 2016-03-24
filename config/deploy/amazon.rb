set :branch, 'master'
set :rvm_ruby_version, '2.2.0'
set :rvm_type, :user
set :deploy_to, '/web/server/tv'
set :rvm_custom_path, '/home/ubuntu/.rvm'
set :rvm_roles, [:app, :web]

server 'ubuntu@52.193.249.239', port: 22, roles: %w[web app db], primary: true