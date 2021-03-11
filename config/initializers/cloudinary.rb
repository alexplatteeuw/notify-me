Cloudinary.config do |config|
  config.cloud_name = "alexplatteeuw"
  config.api_key = Rails.application.credentials.dig(:cloudinary, :api_key)
  config.api_secret = Rails.application.credentials.dig(:cloudinary, :api_secret)
  config.enhance_image_tag = true
  config.static_file_support = false
end
