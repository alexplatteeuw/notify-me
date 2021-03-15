module Tmdb
  module FetchTvShow
    def fetch_tv_show_by(tmdb_id:)
      endpoint = "tv/#{tmdb_id}?append_to_response=credits"
      call(endpoint)
    end
  end
end
