set :branch, 'master'
set :rvm_ruby_version, '2.2.0'
set :rvm_type, :user
set :rvm_custom_path, '/home/ubuntu/.rvm'
set :rvm_roles, [:app, :web]

server 'ubuntu@52.79.74.187', port: 22, roles: %w[web app db], primary: true