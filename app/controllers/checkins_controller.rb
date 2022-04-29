class CheckinsController < ApplicationController

  def create
    @checkin = CheckinService.new.create(checkin_params)
  end

  def update
    @checkin = CheckinService.new.update(params[:id], checkin_params)
  end

  def destroy
    CheckinService.new.destroy(params[:id])

    head :ok
  end

  def upload
    CheckinService.new.upload_ids(params[:id], params[:files])

    head :ok
  end

  private

  def checkin_params
    params.permit(:checkin_time, :checkout_time, :destination_address, :source_address, :purpose_of_visit,
      :customer_id, :checkin_manager_id, :checkout_manager_id, :booking_id, :room_id,:number_of_guests,
      :tariff_amount, :tax_amount, :discount, :plan, :fooding_amount,
      guest_details: [:name, :mobile_number, :age, :gender])
  end

end
