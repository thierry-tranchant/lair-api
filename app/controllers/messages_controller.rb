# frozen_string_literal: true

class MessagesController < ApplicationController
  
  # GET /api/messages
  def index
    render json: {results: Message.all.order(created_at: :desc)}
  end

  # POST /api/messages
  def create
    message = Message.create!(messages_params)

    User.all.each do |user|
      MessagesChannel.broadcast_to(user, message)
    end

    recipient = User.all.select { |user| user.id != messages_params[:author_id] }.first

    OneSignalClient.call(recipient, "#{current_user.username} vous a envoyé un message")

    render json: {result: message}
  end

  private

  def messages_params
    params
      .require(:message)
      .permit(:author_id, :content)
  end
end
