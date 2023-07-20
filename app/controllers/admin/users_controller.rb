# frozen_string_literal: true

module Admin
  # Controller for managing users in the admin panel.
  class UsersController < ApplicationController
    before_action :set_user, only: [:destroy]

    def index
      @users = User.get_non_admin_users(Current.user[:organization_id])
    end

    def new
      @user = User.new
      respond_to(&:js)
    end

    def create
      @user = User.invite_user(Current.user, params[:user][:email])
      respond_to do |format|
        if invitation_sent_successfully?
          flash[:success] = "Invitation sent to #{params[:user][:email]}!"
          format.html { redirect_to admin_users_path }
          format.js {}
          send_invitation_email
        else
          flash.now[:danger] = "Failed to send invitation to #{params[:user][:email]}."
          format.html { render :new }
          format.js { render :new } # TODO: create template error.js.erb to handle errors if any. Add status as well.
        end
      end
    end

    def destroy
      @user.destroy
      respond_to(&:js)
    end

    private

    # Checks if the user invitation was sent successfully.
    def invitation_sent_successfully?
      @user.present? && @user.save
    end

    # Sends an invitation email to the invited user.
    def send_invitation_email
      UserMailer.with(user: @user).invitation_email.deliver_later
    end

    # Finds and sets the user based on the ID parameter.
    def set_user
      @user = User.find(params[:id])
    end
  end
end
