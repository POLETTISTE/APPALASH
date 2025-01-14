# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LashAppRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :en

    # Enable locale fallbacks
    config.i18n.fallbacks = { 'pt-BR' => 'pt', 'fr-CA' => 'fr' }

    # Set a global fallback to `en` for all locales
    config.i18n.fallbacks = true

    # Set the default locale to English

    # Ensure the locales in subdirectories are loaded
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.active_job.queue_adapter = :async

    # https://www.mintbit.com/blog/custom-404-500-error-pages-in-rails
    # https://www.youtube.com/watch?v=moeJ_0WQZxo&t=308s
    config.exceptions_app = routes

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
