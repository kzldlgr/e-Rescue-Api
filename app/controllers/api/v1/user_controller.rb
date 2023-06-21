module Api
  module V1
    class UserController < ApplicationController
      skip_before_action :authenticate_user, only: [:sign_up]
      # before_action :authorize_client
      # before_action :authorize_responder

      def sign_up
        @user = User.new(user_params)
        if @user.valid?
          if @user.password == user_params[:password_confirmation]
            if @user.save
              render json: {
                status: :created,
                user: {
                  id: @user.id,
                  first_name: @user.first_name,
                  last_name: @user.last_name,
                  email: @user.email,
                  username: @user.username,
                  mobile_no: @user.mobile_no,
                  created_at: @user.created_at,
                  updated_at: @user.updated_at,
                }
              }
            else
              render json: { errors: @user.errors.full_messages}, status: 422
            end
          end
        else
          render json: { errors: @user.errors.full_messages}, status: 422
        end
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :role, :mobile_no)
      end
    
    end
  end
end
