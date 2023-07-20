# frozen_string_literal: true

class User::WalletsController < ApplicationController
  def index
    @wallets = Current.user.wallets.order(month: :asc)
    @total_amount = Wallet.total_amount_for_current_year(Current.user)
  end

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Current.user.wallets.build(wallet_params)
    @wallet.year = Date.today.year
    if @wallet.save
      redirect_to wallets_path, success: 'Wallet created successfully.'
    else
      flash.now[:danger] = 'Wallet could not be created.'
      render :new
    end
  end

  private

  def wallet_params
    params.require(:wallet).permit(:amount, :month)
  end
end
