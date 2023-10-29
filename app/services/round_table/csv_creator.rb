# frozen_string_literal: true

require 'csv'

module RoundTable
  class CsvCreator
    def initialize(event:)
      @event = event
    end

    def call!
      matchups =
        @event.matchups
              .includes(:first_team, :second_team)
              .group_by(&:round_number)
              .transform_values do |matchups_array|
                matchups_array.sort_by(&:workshop_name)
              end

      workshop_names = matchups[1].map(&:workshop_name)

      csv_string = CSV.generate do |csv|
        csv << ["Rounds"] + workshop_names

        matchups.each do |round_number, matchups_array|
          csv << ["Round #{round_number}"] + matchups_array.map(&:first_team).map(&:name)
          csv << [""] + matchups_array.map(&:second_team).map(&:name)
          csv << [""] + Array.new(matchups_array.map(&:first_team).length, "")
        end
      end

      tmp_file = Tempfile.new
      tmp_file << csv_string
      tmp_file.open
    end
  end
end
