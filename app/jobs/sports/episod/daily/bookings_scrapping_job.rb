# frozen_string_literal: true

module Sports::Episod
  module Daily
    class BookingsScrappingJob < ApplicationJob
      def perform(hash)
        BookingsCreator.call(hash)
      end
    end
  end
end
