class BookingsController < ApplicationController
  def create
    room = Room.find_by(params[:room_id])
    conflicting_rooms = Room.conflicting_bookings(params[:start], params[:end]).where(id: room.id)
    if conflicting_rooms.present?
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    else
      booking = Booking.new(booking_params)
      booking.save
      render json: { message: 'Booking created.' }, status: :ok
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
