# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :author, class_name: "User"
end
