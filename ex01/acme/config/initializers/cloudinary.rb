Cloudinary.config do |config|
  config.cloud_name = 'dl1hwhz99'
  config.api_key = (ENV['CLOUDINARY_API_KEY']).to_s
  config.api_secret = (ENV['CLOUDINARY_API_SECRET']).to_s
  config.enhance_image_tag = true
  config.secure = true
  config.cdn_subdomain = true
end
