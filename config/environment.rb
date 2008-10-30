APP_ROOT = 'E:/workspace/pps'

RAILS_GEM_VERSION = '2.2.0' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]
  config.plugins = %w( haml )
  
  config.action_controller.session = { :session_key => "_pps_session",
    :secret => 'here_is_a_really_long_secret_ilikeeatingbananaandyoffffffffffffffuphrase' }
end
