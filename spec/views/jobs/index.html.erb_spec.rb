require 'spec_helper'

describe "jobs/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :title => "Title",
        :business => "Business",
        :url => "Url"
      ),
      stub_model(Job,
        :title => "Title",
        :business => "Business",
        :url => "Url"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Business".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
