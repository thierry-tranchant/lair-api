class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate!

  def authenticate!
    render status: :unauthorized if !current_user
  end

  def current_user
    @current_user = begin
      token = /^Bearer (.+)/.match(request.authorization)[1]

      decoded_token = JWT.decode(token, Devise.secret_key, true, {algorithm: "HS256"}).first
      
      user_id = decoded_token.symbolize_keys[:user_id]

      User.find(user_id)
    end
  rescue JWT::DecodeError
    return nil
  end
end
