class JsonWebToken
  class << self
    def encode(payload, exp = 6.hour.from_now)
      payload[:exp] = exp.to_i
      payload[:sub] = payload[:user_id]
      payload[:aud] = Settings[:realm][:app_id]
      payload[:user_data] = {
        name: payload[:user_id]
      }
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    end
  end
end
