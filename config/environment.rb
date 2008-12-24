#APP_ROOT = 'E:/workspace/pps'

RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION


require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer ]
  config.plugins = %w( haml attachment_fu )
  
  config.action_controller.session = {
    :session_key => '_pps_session',
    :secret      => 'fdd9127d4d6c0f74fcae71fb3657d4b1517d56b82197484ff4f3e945a0eb5'
  }

  # use numeric prefix migration name conventions
  config.active_record.timestamped_migrations = false

  config.gem 'haml', :version => '>= 2.0.4'  
  # config.gem 'rmagick'#, :version => '>= 2.7.0'

  # config.gem 'zipruby', :version => '>= 0.2.9' 
  # config.gem 'rspec', :version => '>= 1.1.11', :lib => 'spec'  
  config.gem 'sqlite3-ruby', :lib => 'sqlite3'
end

# ? 'application/octet-stream'
# SolidWorks Part's MimeType is 'application/presentations' or 'image/x-presentations'
Mime::Type.register 'application/octet-stream', :sldprt

ActionView::Helpers::InstanceTag::DEFAULT_FIELD_OPTIONS = {}
