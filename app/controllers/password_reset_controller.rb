class PasswordResetController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      user = User.find_by(email: params[:email])
  
      if user
        # Generate and send password reset instructions
        user.generate_password_reset_token
        UserMailer.password_reset_email(user).deliver_now
  
        render json: { message: "Password reset instructions sent to #{user.email}" }, status: :ok
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end
  end
  