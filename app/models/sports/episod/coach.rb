# frozen_string_literal: true

module Sports::Episod
  class Coach < ApplicationRecord
    has_many :sessions, class_name: "Sports::Episod::Session"
  end
end