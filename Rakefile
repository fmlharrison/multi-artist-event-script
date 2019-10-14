require_relative './lib/multi_artist_events.rb'

task :multi_artist_events, [:artist_ids, :api_key] do |t, args|
  puts "Fetching artists' events"
  ids_array = args[:artist_ids].split(' ')
  results = MultiArtistEvents.run(ids_array, args[:api_key])
  p results
end