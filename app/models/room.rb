class Room < ActiveRecord::Base
  has_many :bookings

  scope :conflicting_bookings,      -> (start, ending)       { joins(:bookings).where("bookings.start == ? OR bookings.end == ?", start, ending  ) }

end
