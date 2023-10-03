# rubocop:disable all

require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #not_found' do
    it 'responds with a 404 status code' do
      get :not_found
      expect(response).to have_http_status(:not_found)
    end

    it 'renders the not_found template' do
      get :not_found
      expect(response).to render_template(:not_found)
    end

    it 'updates the invalid route flag to true' do
      expect(controller).to receive(:update_invalid_route).with(true)
      get :not_found
    end
  end

  describe 'GET #internal_server_error' do
    it 'responds with a 500 status code' do
      get :internal_server_error
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'renders the internal_server_error template' do
      get :internal_server_error
      expect(response).to render_template(:internal_server_error)
    end

    it 'updates the invalid route flag to true' do
      expect(controller).to receive(:update_invalid_route).with(true)
      get :internal_server_error
    end
  end
end
