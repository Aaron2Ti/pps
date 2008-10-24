APP_ROOT = 'E:/workspace/pps'

RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]
  config.plugins = %W( haml css_view_helpers )
  
  config.action_controller.session = { :session_key => "_pps_session",
    :secret => "ilikeeatingbananaandyoffffffffffffffuphrase" }
end
