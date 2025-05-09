# frozen_string_literal: true

# lib/admin_constraint.rb
class AdminConstraint
  def matches?(request)
    user = request.env['warden'].user
    user.present? && user.admin?
  end
end
