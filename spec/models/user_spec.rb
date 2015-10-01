require 'rails_helper'

RSpec.describe User, type: :model do
  describe "passwords" do
    it "needs a password and confirmation to save" do
      u = User.new(name: 'steve', email: 'steve@example.com')

      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "need password and confirmation to match" do
      u = User.create(name: "steve",
                      password: "password",
                      password_confirmation: "anotherpassword")
      expect(u).to_not be_valid
    end
  end

  describe "authentication" do
    let(:user) { User.create(
      name: 'steve',
      password: 'hunter2',
      password_confirmation: 'hunter2') } 

    it "authenticate with correct password" do
      expect(user.authenticate('hunter2')).to be
    end

    it "does not authenticate with incorrect password" do
      expect(user.authenticate('hunter')).to_not be
    end

    it 'requires an email' do
      user.save
      expect(user).to_not be_valid

      user.email = 'steve@example.com'
      user.save
      expect(user).to be_valid
    end
  end
end
