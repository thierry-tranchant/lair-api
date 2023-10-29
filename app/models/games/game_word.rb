# frozen_string_literal: true

module Games
  class GameWord < ApplicationRecord
    self.table_name = 'game_words'

    belongs_to :game, class_name: 'Games::Game'
    belongs_to :word, class_name: 'Games::Word'
  end
end
