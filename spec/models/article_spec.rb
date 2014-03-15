require 'spec_helper'

describe Article do
  let(:user) { FactoryGirl.create(:user) }
  before { @article = user.articles.build(last_editor_id: user.id) }

  subject { @article }

  it { should respond_to(:last_editor_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:paragraphs) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Article.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @article.user_id = nil }
    it { should_not be_valid }
  end
end
