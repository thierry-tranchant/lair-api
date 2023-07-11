# frozen_string_literal: true

module Food
  class Recipe < ApplicationRecord
    include ActiveModel::Serialization

    has_many :cooking_steps, class_name: "Food::CookingStep", dependent: :destroy
    has_many :ingredients, class_name: "Food::Ingredient", dependent: :destroy
    has_one_attached :photo

    enum category: {
      starter: "starter",
      main_dish: "main_dish",
      dessert: "dessert",
    }

    accepts_nested_attributes_for :ingredients, allow_destroy: true
    accepts_nested_attributes_for :cooking_steps, allow_destroy: true

    def translated_categories
      I18n.t("activerecord.attributes.food/recipe/category")
    end

    def photo_url
      photo.url
    end

    def blob_id
      photo.blob&.id
    end

    def attributes
      {
        title: nil,
        cooking_time: nil,
      }
    end
  end
end
