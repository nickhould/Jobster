require 'spec_helper'

describe "scrapers/show" do
  before(:each) do
    @scraper = assign(:scraper, stub_model(Scraper,
      :name => "Name",
      :source => "Source",
      :icon => "Icon"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Source/)
    rendered.should match(/Icon/)
  end
end
