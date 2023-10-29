# frozen_string_literal: true

module Sports::Episod
  module Daily
    class SessionScrappingLaunchJob < ApplicationJob
      def perform
        hashes = Scrapper.sessions

        hashes.each do |hash|
          SessionScrappingJob.perform_later(hash)
        end
      end
    end
  end
end
