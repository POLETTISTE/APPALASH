# set the orm to use UUIDs
# When generate a scaffold, it will automatically put uuid instead id
# https://www.youtube.com/watch?v=P6Kgn6wElPY
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end