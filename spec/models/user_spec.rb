# # spec/models/user_spec.rb
# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe 'validations' do
#     it { should validate_presence_of(:email) }
#     it { should validate_uniqueness_of(:email) }
#     it { should allow_value('test@example.com').for(:email) }
#     it { should_not allow_value('invalid_email').for(:email) }

#     it { should validate_presence_of(:username) }
#     it { should validate_uniqueness_of(:username) }

#     it do
#       should validate_length_of(:password)
#         .is_at_least(6)
#         .on(:create)
#     end
#   end

#   describe 'has_secure_password' do
#     it { should have_secure_password }
#   end
# end
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }

    it do
      should validate_length_of(:password)
        .is_at_least(6)
        .on(:create)
    end
  end

  describe 'password encryption' do
    let(:user) { User.create(email: 'test@example.com', username: 'test_user', password: 'password123') }

    it 'should encrypt the password' do
      expect(user.password_digest).not_to eq('password123')
    end

    it 'should authenticate user with correct password' do
      expect(user.authenticate('password123')).to eq(user)
    end

    it 'should not authenticate user with incorrect password' do
      expect(user.authenticate('incorrect_password')).to eq(false)
    end
  end

  describe 'custom ransackable attributes' do
    it 'should include specified attributes' do
      expect(User.ransackable_attributes).to eq(["created_at", "email", "id", "id_value", "name", "password_digest", "updated_at", "username"])
    end
  end
end
