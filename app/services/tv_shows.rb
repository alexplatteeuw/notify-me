module TvShows
  def fetch_popular_tv_shows
    endpoint           = "tv/popular"
    raw_attributes_set = call_api_for_tv_shows(endpoint)
    attributes_set     = parse_collection(attributes_set: raw_attributes_set, selection: :minimum)
    attributes_set
  end

  def fetch_tv_shows_by(query:)
    endpoint           = "search/tv?query=#{query}"
    raw_attributes_set = call_api_for_tv_shows(endpoint)
    attributes_set     = parse_collection(attributes_set: raw_attributes_set, selection: :maximum)
    attributes_set
  end
  
  def fetch_tv_show_by(tmdb_id:)
    endpoint = "tv/#{tmdb_id}"
    raw_attributes = call_api_for_tv_show(endpoint)
    attributes = parse(attributes: raw_attributes, selection: :maximum)
    attributes
  end
  
  private

  def call_api_for_tv_shows(endpoint)
    call(endpoint)[:results]
  end
  
  def call_api_for_tv_show(endpoint)
    call(endpoint)
  end
end
