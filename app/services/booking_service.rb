class BookingService

  def create(booking_params)
    validations(booking_params, room_params, 'create')

    Booking.create!(booking_params)
  end

  def update(id, booking_params)
    Booking.transaction do
      destroy(id)
      @booking = create(booking_params.merge(id: id))
    end

    @booking
  end

  def destroy(id)
    Booking.find(id).destroy!
  end

  private

  def validations(booking_params, room_params, action)
    booking = Booking.bookings_after("checkin_time")
    delux_room_bookings = booking.sum("delux_rooms")
    super_delux_room_bookings = booking.sum("super_delux_rooms")

    if delux_room_bookings.count + booking_params[:delux_rooms].to_i > 9
      raise ValidationError.new "Delux rooms khali nahi hai"
    end

    if checkedin_rooms_count + booked_rooms_count + room_params.count > 11
      raise ValidationError.new "Rooms pe pehle se booking hai"
    end

    rooms = room_params.map {|room| room[:room_name]}
    raise ValdationError.new "Rooms pehle se checkin hai" if rooms.uniq.count > room_params.count

    if checkedin_rooms & rooms
      raise ValdationError.new "Rooms pehle se checkin hai"
    end

    raise ValidationError.new "Guests ki ginti daale" if booking_params[:number_of_guests].blank?
  end


end
