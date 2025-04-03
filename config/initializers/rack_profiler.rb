# frozen_string_literal: true

if Rails.env.development?
  Rack::MiniProfiler.config.enabled = true
  Rack::MiniProfiler.config.position = 'top-right'
else
  Rack::MiniProfiler.config.enabled = false
end
