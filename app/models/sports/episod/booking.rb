# frozen_string_literal: true

module Sports::Episod
  class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :session, primary_key: :episod_id
  end
end
