class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate!
    
  end

  def current_user
    ap request.authorization
  end

  private

  def access_token(payload)
    JWT.encode(
      payload,
      Devise.secret_key,
      "HS256",
    )
  end
end
