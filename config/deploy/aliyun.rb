set :branch, 'master'
set :rvm_ruby_version, '2.2.0'
set :rvm_type, :user
set :deploy_to, '/home/koogle/tv'
set :rvm_custom_path, '/home/koogle/.rvm'
set :rvm_roles, [:app, :web]

server 'koogle@112.74.115.204', port: 22, roles: %w[web app db], primary: true