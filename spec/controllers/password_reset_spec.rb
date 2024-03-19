# spec/controllers/password_reset_controller_spec.rb
require 'rails_helper'

RSpec.describe PasswordResetController, type: :controller do
  describe 'POST #create' do
    context 'when user is found' do
      let(:user) { create(:user) } # Assuming you have a valid factory for user

      before do
        allow(User).to receive(:find_by).and_return(user)
        allow(UserMailer).to receive_message_chain(:password_reset_email, :deliver_now)
      end

      it 'sends password reset instructions' do
        post :create, params: { email: user.email }

        expect(response).to have_http_status(:ok)
        expect(UserMailer).to have_received(:password_reset_email).with(user)
      end
    end

    context 'when user is not found' do
      it 'returns not found error' do
        post :create, params: { email: 'nonexistent@example.com' }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end
end
