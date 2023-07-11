# frozen_string_literal: true

class ContextsController < ApplicationController
  
  # /api/contexts
  def index
    render json: {result: {current_user: User.first}}
  end
end
