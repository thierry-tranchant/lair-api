# frozen_string_literal: true

module Sports::Episod
  class SessionCreator
    class << self
      def call(hash)
        hash = hash.deep_symbolize_keys.except(:spot_number)

        return unless hash[:sport] == "cycling"

        coach = Coach.find_or_create_by!(name: hash.delete(:coach))

        reservation_hash = Scrapper.reservation(hash[:episod_id])

        Session.create!(hash.merge(reservation_hash).merge(coach: coach))
      end
    end  
  end
end
