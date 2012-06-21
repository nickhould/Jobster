require 'spec_helper'

describe "scrapers/index" do
  before(:each) do
    assign(:scrapers, [
      stub_model(Scraper,
        :name => "Name",
        :source => "Source",
        :icon => "Icon"
      ),
      stub_model(Scraper,
        :name => "Name",
        :source => "Source",
        :icon => "Icon"
      )
    ])
  end

  it "renders a list of scrapers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
  end
end
