Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += [/.*\.js*/, /.*\.css*/]
Rails.application.config.assets.precompile += %w( LTE_admin/lte_admin.css)
Rails.application.config.assets.precompile += %w( LTE_admin/lte_admin.js)
Rails.application.config.assets.precompile += %w( nprogress.css
                                                  login_animation.css )

Rails.application.config.assets.precompile += %w( jquery.blockUI.js
                                                  stop_execution.js
                                                  video_player.js )