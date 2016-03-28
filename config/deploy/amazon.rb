set :branch, 'master'
set :deploy_to, '/www/koogle'
set :rvm_type, :user
set :rvm_roles, [:web, :app]
set :rvm_custom_path, '/home/ubuntu/.rvm'
set :rvm_ruby_version, '2.0.0'

server 'ubuntu@52.193.249.239', port: 22, roles: %w[web app db], primary: true