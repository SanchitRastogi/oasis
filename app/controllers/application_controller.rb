class ApplicationController < ActionController::Base
  include GlobalErrorHandler
  # include PaginationStrongParams
  # include SortingStrongParams

  wrap_parameters format: []
  before_action :authenticate_request, :check_freezed_status
  before_action :set_paper_trail_whodunnit

  attr_reader :current_user

  def set_paper_trail_whodunnit
    PaperTrail.request.whodunnit = (@current_user.present? ? @current_user.mobile_number : 'ghost')
  end

  def authenticate_request
    @current_user = AuthenticationService.new(request.headers).api_request
  end


  def check_freezed_status
    return if @current_user.blank?
    raise ValidationError.new, "User not found" if @current_user.is_freezed == true
  end

end
