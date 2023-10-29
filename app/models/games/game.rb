# frozen_string_literal: true

module Games
  class Game < ApplicationRecord
    self.table_name = 'games'

    has_many :game_teams, class_name: 'Games::GameTeam', dependent: :destroy
    has_many :game_players, class_name: 'Games::GamePlayer', through: :game_teams, dependent: :destroy
    has_many :game_words, class_name: 'Games::GameWord', dependent: :destroy
  end
end
