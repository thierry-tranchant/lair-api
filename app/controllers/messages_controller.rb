# frozen_string_literal: true

class MessagesController < ApplicationController
  
  # /api/messages
  def index
    render json: {results: Message.all.order(created_at: :asc)}
  end

  # /api/messages
  def create
    message = Message.create!(messages_params)

    User.all.each do |user|
      MessagesChannel.broadcast_to(user, message)
    end

    render json: {result: message}
  end

  private

  def messages_params
    params
      .require(:message)
      .permit(:author_id, :content)
  end
end
