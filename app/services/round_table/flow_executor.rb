# frozen_string_literal: true

module RoundTable
  class FlowExecutor
    def initialize(event_params:)
      @event_params = event_params
    end

    def call!
      create_data!
      csv = create_csv!

      event.update!(csv: {io: csv, filename: 'round_table.csv'})
      event
    end

    private

    def event
      @event ||= Event.create!(name: @event_params[:name])
    end

    def create_data!
      DataCreator.new(
        event: event,
        teams_params: @event_params[:teams_attributes],
        workshop_params: @event_params[:workshop_attributes]
      ).call!
    end

    def create_csv!
      CsvCreator.new(event: event).call!
    end
  end
end
