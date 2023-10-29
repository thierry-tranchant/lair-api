# frozen_string_literal: true

module Sports::Episod
  class Mapper
    # The name matching of this file is based on the Episod naming, not the database one.

    SESSIONS_KEYS = {
      "data-id" => "episod_id",
      "data-sport" => "sport",
      "data-hub" => "hub",
      "data-coach" => "coach",
    }.freeze

    BOOKINGS_KEYS = {
      "data-id" => "episod_id",
    }.freeze

    HUB_VALUES = {
      "episod-place-de-clichy" => "clichy",
      "episod-bourse" => "bourse",
      "episod-republique" => "republique",
    }.freeze

    RESERVATION_KEYS = {
      "starts_at" => "starts_at",
      "available_spots" => "available_spots",
      "spots_number" => "spots_number",
      "duration" => "duration",
      "spot" => "spot",
    }.freeze

    DURATION_REGEXP = /(?:[0-9]{1,2})H(?:[0-9]{2} \(([0-9]{2}) min\))/
    BOOKED_STRING = "is-you"

    class << self
      def map(hash, name)
        hash.reduce({}) do |result, array|
          key, value = array
          mapped_key = "Sports::Episod::Mapper::#{name.upcase}_KEYS".constantize[key.to_s]

          result[mapped_key] = mapped_value(mapped_key, value) if mapped_key
          result
        end
      end

      private
    
      def mapped_value(mapped_key, value)
        constant = "Sports::Episod::Mapper::#{mapped_key.upcase}_VALUES".safe_constantize

        constant && constant[value].presence \
          || (respond_to?("#{mapped_key}_value", true) && send("#{mapped_key}_value", value)) \
          || value
      end

      def starts_at_value(value)
        date, time = value

        year = next_year_first_month?(date) ? Time.zone.now.next_year.year : Time.zone.now.year

        DateTime.parse("#{date}/#{year} #{time.split(' (').first}")
      end

      def available_spots_value(value)
        value.map { |hash|
          hash = hash.symbolize_keys
          bookable_string = hash[:class].split(' ').last

          {hash[:id] => bookable_string == 'bookable'}
        }.map(&:symbolize_keys)
      end

      def spots_number_value(value)
        value.length
      end

      def spot_value(value)
        spot = value.find { |hash|
          hash = hash.symbolize_keys
          hash[:class].include?(BOOKED_STRING)
        }
        
        return unless spot

        spot.symbolize_keys[:id]
      end

      def duration_value(value)
        value.match(DURATION_REGEXP)[1]
      end

      def next_year_first_month?(date)
        Time.zone.now.month == Time.zone.now.end_of_year.month \
          && date.split("/").to_i == Time.zone.now.beginning_of_year.month
      end
    end
  end
end
