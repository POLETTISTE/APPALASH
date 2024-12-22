class ProcessAvatarJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.avatar.attach(user.avatar.blob)
  end
end