Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += [/.*\.js*/, /.*\.css*/]
Rails.application.config.assets.precompile += %w( LTE_admin/lte_admin.css)
Rails.application.config.assets.precompile += %w( LTE_admin/lte_admin.js)
Rails.application.config.assets.precompile += %w( nprogress.css video_player.css )
Rails.application.config.assets.precompile += %w( jquery.blockUI.js )
Rails.application.config.assets.precompile += %w( login_animation.css stop_execution.js  )
