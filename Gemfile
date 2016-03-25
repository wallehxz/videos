# source 'https://ruby.taobao.org/'  #淘宝源
source 'https://rubygems.org/'  #官方源

ruby '2.2.0'
gem 'rails', '4.2.5'
gem 'pg', '0.18.4'  # postgresql 数据连接
gem 'will_paginate', '3.0.7'   #数据分页
gem 'faraday', '0.9.2' #HTTP post 、get 请求
gem 'devise','3.5.2' #用户模块
gem 'spring', '1.4.1' # Rails application preloader 预加载
gem 'fume-settable', '0.0.3' #a simple settings plugin for read on yaml, ruby, database, etc
gem 'sass-rails', '5.0.4' # 生成 rails 样式方法
gem 'uglifier', '2.7.2' # 包装处理 javascript 以访问网页
gem 'coffee-rails', '4.1.0' # CoffeeScript adapter for the Rails asset pipeline. 适配器
gem 'jquery-rails', '4.0.5' # provides jQuery and the jQuery-ujs driver 驱动
gem 'turbolinks', '2.5.3'  # makes following links in your web application faster
gem 'jbuilder', '2.3.2' # Build JSON APIs
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.
gem 'qiniu', '6.4.2'  #七牛云存储服务
gem 'bcrypt', '3.1.10' # BCrypt::Password.create
gem 'unicorn', '4.9.0' # Rails Server
#gem 'puma', '2.14.0' #bin/rails s puma -t 4:16 -w 2 -b 0.0.0.0 -p 3000 -e development
# gem 'newrelic_rpm', '3.14.0.305' #网站性能监测
gem 'oneapm_rpm', '1.3.4'
gem 'therubyracer', '0.12.2', :platform => :ruby  # Call Ruby code and manipulate Ruby objects from JavaScript.
group :development, :test do
  gem 'annotate', '2.6.5' # annotate --exclude tests,fixtures,factories,serializers
  gem 'pry-rails', '0.3.4'
  gem 'pry-byebug', '3.3.0'
  gem 'factory_girl_rails', '4.6.0'
  gem 'rspec-rails', '3.4.2'
  gem 'guard-rspec', '4.5.0' #https://github.com/rspec/rspec-rails
end
group :development do
  #项目部署
  gem 'capistrano-rails', '1.1.3' #Rails specific Capistrano tasks 项目部署
  gem 'capistrano-rvm', '0.1.2'
  gem 'capistrano-bundler', '1.1.4'
end