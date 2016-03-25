
ENV['RAILS_ENV'] ||= 'test'
#在生产环境是提示
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
#数据库迁移
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  #声明rspec运行环境
  Shoulda::Matchers.configure do |c|
    c.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # 使用ActiveRecord作为数据模式
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # 支持FactoryGirl数据管理模式
  config.include FactoryGirl::Syntax::Methods

  # 添加测试通列支持
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  # 开启数据转义
  config.use_transactional_fixtures = true

  # 在每个测试用例声明其类型
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

end
