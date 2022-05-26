require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DepotV6
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.web_console.permissions = '172.19.0.1'
    config.load_defaults 6.1
    config.filter_parameters += [ :credit_card_number ]
    config.middleware.use I18n::JS::Middleware
    config.autoload_paths += %W(#{Rails.root}/lib)
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
