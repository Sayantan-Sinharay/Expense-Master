# frozen_string_literal: true

module Admin
  # Controller for managing users in the admin panel.
  class UsersController < ApplicationController
    before_action :authenticate_admin
    before_action :set_user, only: [:destroy]

    include NotificationsHelper

    def index
      @users = User.order(created_at: :desc).get_non_admin_users(Current.user[:organization_id])
    end

    def new
      @user = User.new
      respond_to(&:js)
    end

    def create
      respond_to do |format|
        if valid_email?
          @user = User.create_user(@user)
          handle_successful_invitation(format) if invitation_sent_successfully?
        else
          handle_failed_invitation(format)
        end
      end
    end

    def destroy
      flash = { danger: "#{@user.email} has been removed!" }
      @user.destroy
      send_flash(Current.user, flash)
      respond_to(&:js)
    end

    private

    def invitation_sent_successfully?
      @user.valid? && @user.save
    end

    def send_invitation_email
      UserMailer.with(user: @user).invitation_email.deliver_later
    end

    def set_user
      @user = User.find(params[:id])
    end

    def valid_email?
      @user = Current.user.organization.users.new(email: params[:user][:email])
      @user.errors[:email].empty? unless @user.valid?
    end

    def handle_successful_invitation(format)
      flash = { success: "Invitation sent to #{params[:user][:email]}!" }
      send_flash(Current.user, flash)
      format.html { redirect_to admin_users_path }
      format.js
      send_invitation_email
    end

    # Handles failed user invitation.
    def handle_failed_invitation(format)
      format.html { render :new }
      format.js { render :new }
    end
  end
end
