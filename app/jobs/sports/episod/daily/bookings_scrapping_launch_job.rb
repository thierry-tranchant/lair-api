# frozen_string_literal: true

module Sports::Episod
  module Daily
    class BookingsScrappingLaunchJob < ApplicationJob
      def perform
        User.all.each do |user|
          bookings = Scrapper.bookings(user.id)
          
          bookings.each do |booking|
            BookingsScrappingJob.perform_later(booking)
          end
        end
      end
    end
  end
end
