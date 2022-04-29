class CustomersController < ApplicationController

  def create
    @customer = Customer.create!(customer_params)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update_attirbutes!(customer_params)
  end

  def upload
    customer = Customer.find(params[:id])

    Docuement.create!(
      documentable_id: customer.id,
      documentable_type: 'Customer',
      document: params[:document],
      document_type: params[:document_type]
    )
  end

  private

  def customer_params
    params.permit(:email, :name, :mobile_number, :date_of_birth, :billing_name, :gst_number, :address,
      :state, :pincode)
  end

end
