# frozen_string_literal: true

module Sports::Episod
  class Session < ApplicationRecord
    belongs_to :coach, class_name: "Sports::Episod::Coach"
  end
end
