# frozen_string_literal: true

module RoundTable
  class DataCreator
    def initialize(event:, teams_params:, workshop_params:)
      @event = event
      @teams_params = teams_params
      @workshop_params = workshop_params
    end

    def call!
      round_lines = JSON.parse(algorithm_raw_result)

      @event.update!(rounds_count: round_lines.length)

      round_lines.each_with_index do |round_line, round_index|
        matchups = round_line.last

        matchups.each_with_index do |matchup, matchup_index|
          create_matchup!(matchup, round_index, matchup_index)
        end
      end
    end

    private

    def algorithm_raw_result
      path = Rails.root.join('app/algorithms/team.py').to_s

      %x[python3 #{path} #{@teams_params.length}]
    end

    def create_matchup!(matchup, round_index, matchup_index)
      workshop_name =
        @workshop_params.dig(matchup_index, :name).presence \
          || "Atelier #{matchup_index + 1}"

      Matchup.create!(
        event: @event,
        round_number: round_index + 1,
        workshop_name: workshop_name,
        first_team: teams(matchup.first),
        second_team: teams(matchup.second),
      )
    end

    def teams(number)
      ap @teams_params
      @teams ||= {}
      @teams[number] ||=
        Team.find_or_create_by!(
          number: number,
          name: @teams_params.dig(number - 1, :name).presence || "Équipe #{number}",
          event: @event,
        )
    end
  end
end
