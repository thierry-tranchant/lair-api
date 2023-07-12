# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :authenticate!

  private

  def respond_with(resource, opts = {})
    if request.method == "GET"
      super
    else
      render json: {
        access_token: encrypted_access_token(resource.id),
        resource: resource,
      }
    end
  end

  def encrypted_access_token(user_id)
    JWT.encode(
      {user_id: user_id},
      Devise.secret_key,
      "HS256",
    )
  end
end