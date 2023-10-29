# frozen_string_literal: true

module Games
  class Word < ApplicationRecord
    self.table_name = 'words'

    has_many :game_words, class_name: 'Games::GameWord', dependent: :nullify
  end
end
