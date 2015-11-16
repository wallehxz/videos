#source 'https://ruby.taobao.org/'  #淘宝源
source 'https://rubygems.org/'  #官方源

ruby '2.0.0'
gem 'rails', '4.2.2'
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
gem 'rails_12factor', group: :production
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.
gem 'qiniu', '6.4.2'  #七牛云存储服务
gem 'unicorn', '4.9.0' # Rails Server
#gem 'puma', '2.14.0'
gem 'newrelic_rpm', '3.14.0.305' #网站性能监测
# Rails Server  bin/rails s puma -t 4:16 -w 2 -b 0.0.0.0 -p 3000 -e development
gem 'therubyracer', '0.12.2', :platform => :ruby  # Call Ruby code and manipulate Ruby objects from JavaScript.
gem 'guard-livereload', '2.4.0' #automatically reloads your browser when 'view' files are modified
group :development, :test do
  gem 'annotate', '2.6.5' #注释 https://github.com/ctran/annotate_models
  gem 'byebug', '3.5.1'        # anywhere in the code to stop execution and get a debugger console  调试
  gem 'web-console', '2.0.0' # A set of debugging tools for your Rails application.
  #Turn Pry into a primitive debugger. Adds 'step' and 'next' commands to control execution.
  #项目调试
  gem 'pry-nav', '0.2.4'
  gem 'pry-doc', '0.6.0'
  gem 'rspec-rails', '3.4.0'  # http://www.rubydoc.info/gems/rspec-rails/frames 项目测试
  gem 'guard-rspec', '4.5.0' #https://github.com/rspec/rspec-rails
end
group :development do
  #项目部署
  gem 'capsum', '1.0.2', require: false #Collect gems and recipes related capistrano
  gem 'capistrano-sidekiq', "0.3.8", require: false
  gem 'capistrano-rails', '1.1.3' #Rails specific Capistrano tasks 项目部署
  gem 'capistrano-rvm', '0.1.2'
  gem 'capistrano-bundler', '1.1.4'
end