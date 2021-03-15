module Tmdb::FetchTvShow
  def fetch_tv_show_by(tmdb_id:)
    endpoint = "tv/#{tmdb_id}"
    raw_attributes = call(endpoint)
    attributes = parse(attributes: raw_attributes, selection: :maximum)
    attributes
  end
end
