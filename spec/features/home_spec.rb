require 'spec_helper'

feature 'Home/Root page' do
  scenario "navigate to page" do
    visit root_url
    current_path.should == root_path
    find_link 'Ladyparts'
    click_button 'The Bechdel Test'
    click_button 'Explore films by critics score'
    click_button 'Explore films by director'
    save_and_open_page
  end
end
