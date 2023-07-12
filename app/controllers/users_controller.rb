# frozen_string_literal: true

class UsersController < ApplicationController
  # /api/users
  def index
    render json: {results: User.all}
  end
end
