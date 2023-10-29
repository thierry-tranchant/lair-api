# frozen_string_literal: true

module RoundTable
  class Event < ApplicationRecord
    self.table_name = 'round_table_events'

    has_many :matchups, class_name: 'RoundTable::Matchup', dependent: :destroy
    has_many :teams, class_name: 'RoundTable::Team', dependent: :destroy
    has_one_attached :csv

    def csv_url
      Rails.application.routes.url_helpers.rails_blob_url(
        csv,
        host: Rails.application.credentials.dig(:host, Rails.env.to_sym),
      )
    end
  end
end
