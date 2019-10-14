require 'httparty'

class MultiArtistEvents
  
  def self.run(artist_ids, api_key)
    task = MultiArtistEvents.new(artist_ids, api_key)
    task.get_events
  end

  include HTTParty
  base_uri "https://api.songkick.com"

  attr_reader :events

  def initialize(artist_ids, api_key)
    @artist_ids = artist_ids
    @api_key    = api_key
    @options    = { query: { apikey: api_key } }
    @events     = []
  end

  def get_events
    @artist_ids.each do |id|
      response = request(id)
      events.push(response.parsed_response["resultsPage"]["results"]["event"]).flatten!
    end

    results = {
      'artsit_ids' => @artist_ids,
      'events'     => events,
      'count'      => events.length
    }

    results
  end

  private

  def request(id)
    artist_events_slug = "/api/3.0/artists/#{id}/calendar.json"
    self.class.get(artist_events_slug, @options)
  end
end