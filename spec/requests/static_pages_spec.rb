#encoding: utf-8
require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Webjobs') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: 'Home |' }
  end

  describe "About page" do
    before { visit a_propos_path }

    it { should have_selector('h1',    text: 'À propos') }
    it { should have_selector('title', text: full_title('À propos')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "À propos"
    page.should have_selector 'title', text: full_title('À propos')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Accueil"
    page.should have_selector 'title', text: full_title('')
  end
end 