# frozen_string_literal: true

module Sports::Episod
  module Daily
    class SessionScrappingJob < ApplicationJob
      def perform(hash)
        SessionCreator.call(hash)
      end
    end
  end
end
