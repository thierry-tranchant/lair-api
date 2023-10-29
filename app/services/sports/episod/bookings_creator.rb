# frozen_string_literal: true

module Sports::Episod
  class BookingsCreator
    class << self
      def call(hash)
        booking = Booking.find_or_create_by!(hash.deep_symbolize_keys.except(:spot))

        Booking.update!(hash.deep_symbolize_keys)
      end
    end  
  end
end
