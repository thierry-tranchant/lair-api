# frozen_string_literal: true

module RoundTable
  class Team < ApplicationRecord
    self.table_name = 'round_table_teams'

    belongs_to :event, class_name: 'RoundTable::Event'
    has_many :matchups, class_name: 'RoundTable::Matchup'
  end
end
