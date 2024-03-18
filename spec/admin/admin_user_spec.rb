require 'rails_helper'

RSpec.describe AdminUser, type: :request do
  
  before do
    @admin_user = FactoryBot.create(:admin_user)
    sign_in @admin_user
  end

  describe 'GET#index' do
    it 'returns a success response' do
      get '/admin_users'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET#show' do
    it 'returns a success response' do
      get '/admin_user', params: { id: @admin_user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST#create' do
    it 'creates a new admin user' do
      post '/admin/admin_users', params: { email: Faker::Internet.unique.email, password: 'password', password_confirmation: 'password' }

      expect(response).to have_http_status(200)
    end
  end


  describe 'PATCH#update' do
    it 'updates the admin user' do
      new_email = 'new_email@example.com'
      patch "/admin/admin_users/#{ @admin_user.id }", params: { admin_user: { email: new_email } }
      @admin_user.reload
      expect(@admin_user.email).to eq(new_email)
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the admin user' do
      expect {
        delete "/admin/admin_users/#{ @admin_user.id }"
      }.to change(AdminUser, :count).by(-1)
    end
  end
end
