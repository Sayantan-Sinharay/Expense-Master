# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :require_login
  def not_found
    update_invalid_route(true)
    render status: :not_found
  end

  def internal_server_error
    update_invalid_route(true)
    render status: :internal_server_error
  end
end
