# frozen_string_literal: true

class ContextsController < ApplicationController
  skip_before_action :authenticate!

  # /api/contexts
  def index
    render json: {result: {current_user: current_user}}
  end
end
