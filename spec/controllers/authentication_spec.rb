# spec/controllers/authentication_controller_spec.rb
require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      before do
        post :login, params: { email: user.email, password: 'password' }
      end

      it 'returns a JWT token' do
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['token']).to be_present
      end

      it 'returns an expiration time' do
        json_response = JSON.parse(response.body)
        expect(json_response['exp']).to be_present
      end

      it 'returns the username' do
        json_response = JSON.parse(response.body)
        expect(json_response['username']).to eq(user.username)
      end
    end

    context 'with invalid credentials' do
      before do
        post :login, params: { email: user.email, password: 'invalid' }
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
