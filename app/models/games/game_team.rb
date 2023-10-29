# frozen_string_literal: true

module Games
  class GameTeam < ApplicationRecord
    self.table_name = 'game_teams'

    belongs_to :game, class_name: 'Games::Game'
    has_many :game_players, class_name: 'Games::GamePlayer', dependent: :destroy
  end
end
