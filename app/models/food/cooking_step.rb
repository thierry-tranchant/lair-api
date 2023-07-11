# frozen_string_literal: true

module Food
  class CookingStep < ApplicationRecord
    include ActiveModel::Serialization

    belongs_to :recipe, class_name: "Food::Recipe"

    def attributes
      {
        id: nil,
        title: nil,
        number: nil,
        description: nil,
      }
    end
  end
end
