module GlobalErrorHandler extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :render_custom_exception_response
  end

  #both error and errors keys for backward compatibility

  def render_custom_exception_response(exception)
    Rails.logger.error(exception)

    data = { params_data: params.merge!(request_id: request.try(:request_id)) }
    if params[:password].present? || params[:otp].present? || params[:mfa].present? || params[:otp_code].present?
      data = { mobile_number: params[:mobile_number] }
    end
    if exception.class == ValidationError
      render json: {error_code: exception.code, error: exception.message, errors: [exception.message] }, status: :bad_request

    elsif exception.class == AuthError
      render json: { error: exception.message, errors: [exception.message] }, status: :unauthorized

    elsif exception.class == ActiveRecord::RecordInvalid
      render json: {
        error: exception.record.errors.full_messages.first,
        errors: exception.record.errors.full_messages
      }, status: :unprocessable_entity

    elsif exception.class == ActionController::ParameterMissing
      render json: { error: exception.message, errors: [exception.message] }, status: :unauthorized

    elsif exception.class == ActiveRecord::RecordNotFound
      Airbrake.notify(exception, data)
      render json: { error: 'Record not found', errors: ['Record not found'] }, status: :not_found

    elsif exception.class == Mongoid::Errors::DocumentNotFound
      Airbrake.notify(exception, data)
      render json: { error: 'Document not found', errors: ['Document not found'] }, status: :not_found

    elsif exception.class == ActiveRecord::StaleObjectError
      Airbrake.notify(exception, data)
      render json: { error: 'Another activity is in progress.', errors: ['Another activity is in progress.'] }, status: :bad_request

    else
      Airbrake.notify(exception, data)
      render json: { error: "Please try after some time", errors: ["Please try after some time"] }, status: :internal_server_error
    end

  end
end
