BASE_URL  = "https://api.themoviedb.org/3/".freeze
IMAGE_URL = "https://image.tmdb.org/t/p/".freeze
API_KEY   = Rails.application.credentials.dig(:tmdb, :api_read_access_token).freeze
HEADERS   = { "Authorization" => "Bearer #{API_KEY}", "Content-Type" => "application/json;charset=utf-8" }.freeze
SEASON_ATTRIBUTES = %i[id air_date season_number name overview still_path poster_path vote_average episode_count].freeze
EPISODE_ATTRIBUTES = %i[id air_date episode_number name overview season_number still_path vote_average].freeze
PERSON_ATTRIBUTES = %i[id name known_for_department popularity profile_path job character].freeze
TV_SHOW_MIN_ATTRIBUTES = %i[id name poster_path vote_average]
TV_SHOW_MAX_ATTRIBUTES = %i[id name poster_path vote_average backdrop_path episode_run_time first_air_date number_of_seasons overview status tagline]
