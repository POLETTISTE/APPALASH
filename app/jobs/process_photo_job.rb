# app/jobs/process_photo_job.rb
class ProcessPhotoJob < ApplicationJob
  queue_as :default

  def perform(client)
    client.photo.attach(client.photo.blob)
  end
end