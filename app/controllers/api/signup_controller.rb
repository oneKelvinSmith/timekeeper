module Api
  class SignupController < Api::BaseController
    skip_before_action :doorkeeper_authorize!
    skip_before_action :authenticate_user!

    def register
      user = User.new(signup_params)

      if user.save
        render json: user, status: :created, adapter: :json
      else
        render json: errors(user.errors), status: :unprocessable_entity
      end
    end

    private

    def signup_params
      params.permit(:email, :password)
    end
  end
end
