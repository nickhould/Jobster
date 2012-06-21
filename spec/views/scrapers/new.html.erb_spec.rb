require 'spec_helper'

describe "scrapers/new" do
  before(:each) do
    assign(:scraper, stub_model(Scraper,
      :name => "MyString",
      :source => "MyString",
      :icon => "MyString"
    ).as_new_record)
  end

  it "renders new scraper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => scrapers_path, :method => "post" do
      assert_select "input#scraper_name", :name => "scraper[name]"
      assert_select "input#scraper_source", :name => "scraper[source]"
      assert_select "input#scraper_icon", :name => "scraper[icon]"
    end
  end
end
