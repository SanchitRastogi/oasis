class AuthenticationService
  def initialize(parameters = {})
    @parameters = parameters
  end

  def api_request
    set_user
    @user
  end

  def user
    user = validate_user

    token = JsonWebToken.encode({user_id: user.id},  9.hours.from_now)
    user.update!(auth_token: token)

    {
      token: token,
      name: user.name,
      mobile_number: user.mobile_number,
      id: user.id,
      role: user.role.to_s,
      token_expiry: 2592000
    }
  end

  private

  def set_user
    @user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    if @user.present?
      raise AuthError.new, "You have been logged out." if @user.auth_token != http_auth_header
    end
  rescue
    raise AuthError.new, "You have been logged out."
  end

  def decoded_auth_token
    JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if @parameters['Authorization'].present?
      return @parameters['Authorization'].split(' ').last
    else
      raise ValidationError.new 'Permission denied.'
    end
    nil
  end

  def validate_user
    raise ValidationError.new, "Please enter your mobile number." if @parameters[:mobile_number].blank?
    raise ValidationError.new, "Please enter password" if @parameters[:password].blank?
    user = User.find_by(mobile_number: @parameters[:mobile_number])
    raise ValidationError.new, "Mobile number and password combination does not exist" if user.blank?
    raise ValidationError.new, "Mobile number and password combination does not exist" unless user.authenticate(@parameters[:password])
    user
  end
end
