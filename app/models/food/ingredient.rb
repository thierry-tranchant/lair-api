# frozen_string_literal: true

module Food
  class Ingredient < ApplicationRecord
    include ActiveModel::Serialization

    belongs_to :recipe, class_name: "Food::Recipe"

    def attributes
      {
        id: nil,
        title: nil,
        quantity: nil,
        unity: nil,
      }
    end
  end
end
