#source 'https://gems.ruby-china.org'  #Ruby-China源
source 'https://rubygems.org/'  #官方源

gem 'rails', '4.2.5'
gem 'pg', '0.18.4'  # postgresql 数据连接
gem 'will_paginate', '3.0.7'   #数据分页
gem 'faraday', '0.9.2' #HTTP post 、get 请求
gem 'devise','3.5.2' #用户模块
gem 'spring', '1.4.1' # Rails application preloader 预加载
gem 'fume-settable', '0.0.3' #a simple settings plugin for read on yaml, ruby, database, etc
gem 'sass-rails', '5.0.4' # 生成 rails 样式方法
gem 'uglifier', '2.7.1' # 包装处理 javascript 以访问网页
gem 'coffee-rails', '4.1.1' # CoffeeScript adapter for the Rails asset pipeline. 适配器
gem 'jquery-rails', '4.0.5' # provides jQuery and the jQuery-ujs driver 驱动
gem 'turbolinks', '2.5.3'  # makes following links in your web application faster
gem 'jbuilder', '2.3.2' # Build JSON APIs
gem 'qiniu', '6.4.2'  #七牛云存储服务
gem 'bcrypt', '3.1.10' # BCrypt::Password.create
gem 'listen', '3.0.8'
gem 'puma', '3.6.0' #Server
# gem 'newrelic_rpm', '3.14.0.305' #网站性能监测
gem 'oneapm_rpm', '1.3.4'
group :production do
  gem 'therubyracer'
end
# gem 'therubyracer', '0.12.2', :platform => :ruby  # Call Ruby code and manipulate Ruby objects from JavaScript.
group :development, :test do
  gem 'annotate', '2.6.5' # annotate --exclude tests,fixtures,factories,serializers
  gem 'pry-rails', '0.3.4'
  gem 'factory_girl_rails', '4.6.0'
  gem 'rspec-rails', '3.4.2'
  gem 'guard-rspec', '4.5.0' #https://github.com/rspec/rspec-rails
end
group :development do
  #项目部署
  gem "capsum", "~> 1.0.0", require: false
  gem 'capistrano-rails', '1.1.3' #Rails specific Capistrano tasks 项目部署
  gem 'capistrano-rvm', '0.1.2'
  gem 'capistrano-bundler', '1.1.4'
  gem 'capistrano3-puma', '1.2.1'
  gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.
end