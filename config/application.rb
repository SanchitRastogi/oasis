require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oasis
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators.system_tests = nil

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib/exceptions')
    config.autoload_paths << Rails.root.join('lib/exceptions/validation_error')
    config.autoload_paths << Rails.root.join('lib/exceptions/auth_error')

    config.time_zone = 'Kolkata'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    Rails.application.config.active_record.belongs_to_required_by_default = false

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
