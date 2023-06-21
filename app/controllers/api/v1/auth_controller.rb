module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user, only: [:sign_in]

      def sign_in
        if user_params[:email].blank? || user_params[:password].blank?
          render json: { errors: "Fields can't be blank" }, status: 422
        else
          @user = User.find_by_email(user_params[:email])
          if @user&.authenticate(user_params[:password])
            token = jwt_encode(user_id:@user.id)
            time = Time.now + 24.hours.to_i
            render json: { 
              id: @user.id,
              email: @user.email,
              username: @user.username,
              token: token,
              exp: time.strftime("%m-%d-%Y %H:%M"),
              full_name: "#{@user.first_name} #{@user.last_name}"
            }, status: 200
          else
            render json: { errors: "Invalid email/password credentials" }, status: 401
          end
        end
      end
      
      private
      
      def user_params
        params.permit(:email, :password)
      end
    end
  end
end