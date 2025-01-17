# frozen_string_literal: true

# lib/tasks/clean_active_storage.rake
# used to clean orphaned attachments, created when used uuid for guest model and have buggs with active record
namespace :active_storage do
  desc 'Delete orphaned attachments'
  task purge_orphaned: :environment do
    puts 'Deleting orphaned attachments...'

    # Find all orphaned blobs (attachments without any associated record)
    orphaned_blobs = ActiveStorage::Blob.left_outer_joins(:attachments).where(active_storage_attachments: { id: nil })

    orphaned_blobs.each do |blob|
      # Purge the orphaned blob (delete from storage)
      blob.purge
      puts "Purged blob with id #{blob.id}"
    end

    puts 'Orphaned attachments deleted successfully.'
  end
end
