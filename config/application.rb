require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module JustingXX
  class Application < Rails::Application

    config.assets.enabled = true

    config.time_zone = 'Beijing'                   #时区

    config.i18n.default_locale = :'zh-CN'          #默认语言

    config.active_record.default_timezone = :local #设置数据库时间解决数据时差问题

    config.i18n.enforce_available_locales = false

    config.generators do |g|                       #自定义项目模板
      g.assets          :false
      g.stylesheets     :false
      g.javascripts     :false
      g.template_engine :erb
      g.test_framework  :rspec, fixture: true
      g.fixture_replacement :factory_girl
    end

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => 'smtp.exmail.qq.com',
      :port => "587",
      :user_name => "password@tsinova.com",
      :password => "Tsinova2016",
      :authentication => "login",
      :enable_starttls_auto => true,
      :openssl_verify_mode => 'none'
    }
  end
end
