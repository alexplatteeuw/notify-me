BASE_URL  = "https://api.themoviedb.org/3/".freeze
IMAGE_URL = "https://image.tmdb.org/t/p/".freeze
API_KEY   = Rails.application.credentials.dig(:tmdb, :api_read_access_token).freeze
HEADERS   = { "Authorization" => "Bearer #{API_KEY}", "Content-Type" => "application/json;charset=utf-8" }.freeze
