require 'spec_helper'

describe "paragraphs/show" do
  before(:each) do
    @paragraph = assign(:paragraph, stub_model(Paragraph,
      :language => 1,
      :content => "Content",
      :article_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Content/)
    rendered.should match(/2/)
  end
end
