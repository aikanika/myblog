require_relative 'boot'

require 'rails/all'
########
#require 'log4r'
# outputter = Log4r::FileOutputter.new('log4r', filename: 'foobar.log')
# outputter.formatter = Log4r::PatternFormatter.new(
#   date_pattern: "%FT%T.000Z", pattern: "%d [%l] %m"
# )
#
# logger = Log4r::Logger.new('log4r')
# logger.outputters = [outputter]
#########

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myblog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

  end
end
