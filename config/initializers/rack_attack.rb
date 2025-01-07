# frozen_string_literal: true

module Rack
  class Attack
    # Limiter les requêtes par IP (ici, 5 requêtes par seconde par IP)
    throttle('req/ip', limit: 5, period: 1.second, &:ip)
  end
end
