class CheckinService

  def create(checkin_params)
    validations(checkin_params)

    Checkin.create!(checkin_params)
  end

  def update(id, checkin_params)
    Checkin.transaction do
      destroy(id)
      @checkin = create(checkin_params.merge(id: id))
    end

    @checkin
  end

  def destroy(id)
    checkin = Checkin.find(id)

    # Checkin.transaction do
      # checkin.checkedin_rooms.destroy_all
    checkin.destroy!
    # end
  end

  def upload(id, files)
    checkin = Checkin.find(id)

    files.each do |file|
      Document.create!(
        documentable_id: checkin.id,
        documentable_type: 'Checkin',
        document: file
      )
    end
  end

  private

  def validations(checkin_params)
    # checkedin_rooms = Checkin.todays_checkedin_rooms.pluck("rooms.room_name")
    # checkedin_rooms_count = checkedin_rooms.count

    occupied_rooms = Checkin.occupied_rooms
    if occupied_rooms.find_by_room_id(checkin_params[:room_id]).exists?
      raise ValidationError.new "Room khali nahi hai"
    end

    todays_bookings = Booking.todays_bookings

    checkin_room = Room.find(checkin_params[:room_id])

    if occupied_rooms.send(checkin_room.room_type).where(booking_id: nil).count +
        todays_bookings.sum(checkin_room.room_type).count > Room.send(checkin_room.room_type).count

      raise ValidationError.new, "Rooms pe pehle se booking hai"
    end

    # if checkedin_rooms_count + booked_rooms_count + room_params.count > 11
    #   raise ValidationError.new "Rooms pe pehle se booking hai"
    # end

    # rooms = room_params.map {|room| room[:room_name]}
    # raise ValdationError.new "Rooms pehle se checkin hai" if rooms.uniq.count > room_params.count

    # if checkedin_rooms & rooms
    #   raise ValdationError.new "Rooms pehle se checkin hai"
    # end
  end


end
