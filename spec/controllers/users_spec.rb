# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end


  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { name: 'John', username: 'john_doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
        }.to change(User, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { name: 'John', username: 'john_doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity status' do
        post :create, params: { name: 'John', username: 'john_doe', email: 'invalid_email', password: 'password', password_confirmation: 'password' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { FactoryBot.create(:user) }

    context 'with valid parameters' do
      it 'updates the requested user' do
        put :update, params: { id: user.id, name: 'Updated Name' }
        user.reload
        expect(user.name).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity status' do
        put :update, params: { id: user.id, email: 'invalid_email' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryBot.create(:user) }

    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end
  end
end
