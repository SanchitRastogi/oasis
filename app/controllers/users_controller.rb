class UserController < ApplicationController

  def login
    data = AuthenticationService.new(login_params).user
    render json: data
  end

end
