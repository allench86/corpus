# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before {
    @user = User.new(name: "Example User", username: "user_name",
                     password: "foobar", password_confirmation: "foobar")
  }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:username) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:articles) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  context "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  context "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  context "when username format is invalid" do
    it "should be invalid" do
      usernames = [ "user name", "user_at_foo.org", "exampleuser@foo",
                     "----", "123_dd"]
      usernames.each do |invalid_username|
        @user.username = invalid_username
        @user.should_not be_valid
      end
    end
  end

  context "when username format is valid" do
    it "should be valid" do
      usernames = [ "user_name-123", "abc", "user_name",
                    "a123", "user-name"]
      usernames.each do |valid_username|
        @user.username = valid_username
        @user.should be_valid
      end
    end
  end

  context "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  context "when name contains sequential spaces" do
    before {
      @user.name = "abc    deda  fsd"
      @user.save
    }

    it "should be squished" do
      @user.name { should eq("abc deda fsd") }
    end
  end

  context "when name is empty" do
    before {
      @user.name = nil
      @user.save
    }

    it { should be_valid }
  end

  context "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  context "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  context "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  context "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_username(@user.username) }

    context "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
