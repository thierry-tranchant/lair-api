# frozen_string_literal: true

module Food
  class RecipesController < ApplicationController

    # GET /api/recipes
    def index
      recipes = Recipe.where(category: recipe_params[:category])

      render json: {
        results:
          recipes.map do |recipe|
            recipe.serializable_hash(
              methods: [:photo_url],
            )
          end
      }
    end

    # GET /api/recipes/:id
    def show
      recipe = Recipe.find_by(id: params[:id])

      render json: {
        result: recipe.serializable_hash(
          methods: [:photo_url, :blob_id],
          include: {
            ingredients: {only: ['id', 'title', 'quantity', 'unity']},
            cooking_steps: {only: ['id', 'title', 'number', 'description']},
          }
        )
      }
    end

    # POST /api/recipes
    def create
      recipe = Recipe.create!(recipe_params)

      render json: {result: recipe}
    end

    # PUT /api/recipes/:id
    def update
      recipe = Recipe.find_by(id: params[:id])
      recipe.update!(recipe_params)

      render json: {result: recipe}
    end

    private 

    def recipe_params
      params
        .require(:recipe)
        .permit(
            :title,
            :cooking_time,
            :draft_step,
            :category,
            :blob_id,
            ingredients_attributes: [:id, :title, :quantity, :unity, :_destroy],
            cooking_steps_attributes: [:id, :description, :title, :number, :_destroy],
            photo: [:io, :filename],
        ).tap do |parameters|
          if parameters[:blob_id].blank? && parameters[:photo]
            parameters[:photo][:io] = sanitize_file(parameters.dig(:photo, :io))
          else
            parameters.delete(:blob_id)
            parameters.delete(:photo) if parameters[:photo]
          end
        end
    end

    def sanitize_file(file)
      return if !file

      tmp_file = Tempfile.new
      tmp_file << Base64.decode64(file).force_encoding("UTF-8")
      tmp_file.open
    end
  end
end
