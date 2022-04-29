# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'                                   # required
#   config.fog_credentials = {
#     provider: 'AWS',                                                # required
#     aws_access_key_id: Settings['aws']['access_key_id'],            # required
#     aws_secret_access_key: Settings['aws']['secret_access_key'],    # required
#     region: 'ap-south-1'
#   }
#   config.fog_directory  = 'dev-koinex'                              # required
#   config.fog_directory  = 'actual-dev-koinex' if Rails.env.dev?
#   config.fog_public     = false                                     # optional, defaults to true
#   config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
# end

# module CarrierWave
#   module MiniMagick
#     def quality(percentage)
#       manipulate! do |img|
#         img.quality(percentage.to_s)
#         img = yield(img) if block_given?
#         img
#       end
#     end
#   end
# end
