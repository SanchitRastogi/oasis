class BookingsController < ApplicationController

  def create
    @booking = BookingService.new.create(booking_params)
  end

  def update
    @booking = BookingService.new.update(params[:id], booking_params)
  end

  def cancel
    @booking = Booking.find(params["id"])
    @booking.update(cancelled_at: params[:cancelled_at] || Datetime.current)
  end

  private

  def booking_params
    params.permit(:delux_rooms, :super_delux_rooms, :basement_hall, :recepetion_hall, :description, :amount, :customer_id, :user_id, :date, :checkin_time, :checkout_time)
  end

end
