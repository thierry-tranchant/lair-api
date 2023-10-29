# frozen_string_literal: true

module RoundTable
  class Matchup < ApplicationRecord
    self.table_name = 'round_table_matchups'

    belongs_to :first_team, class_name: 'RoundTable::Team'
    belongs_to :second_team, class_name: 'RoundTable::Team'
    belongs_to :event, class_name: 'RoundTable::Event'
  end
end
