# frozen_string_literal: true

if Rails.env.development?
  Rack::MiniProfiler.config.enabled = true
  Rack::MiniProfiler.config.position = 'top-left'
else
  Rack::MiniProfiler.config.enabled = false
end
