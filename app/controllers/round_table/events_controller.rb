# frozen_string_literal: true

module RoundTable
  class EventsController < ApplicationController
    skip_before_action :authenticate!

    def index
      @events =
        Event
          .all
          .includes(:teams)
          .order(created_at: :desc)

      render :index
    end

    def create
      event = FlowExecutor.new(event_params: event_params).call!

      redirect_to '/round_table/events'
    end

    private

    def event_params
      params.require(:event).permit(
        :name,
        teams_attributes: [:name],
        workshop_attributes: [:name],
      )
    end
  end
end
