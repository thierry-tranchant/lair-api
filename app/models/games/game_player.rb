# frozen_string_literal: true

module Games
  class GamePlayer < ApplicationRecord
    self.table_name = 'game_players'

    belongs_to :game_team, class_name: 'Games::GameTeam'
    belongs_to :web_user
  end
end
