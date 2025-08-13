class Api::V1::Admin::AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    user = User.find_by("username = :value OR email = :value", value: params[:emailOrUsername])
    authenticated_user = user&.authenticate(params[:password])

    if authenticated_user
      token = JsonWebToken.encode(user_id: user.id)
      expires_at = JsonWebToken.decode(token)[:exp]

      render json: { token:, expires_at:, id: user.id, username: user.username }, status: :ok
    else
      render json: { error: "Invalid user naem or password." }, status: :unauthorized
    end
  end
end
