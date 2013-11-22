require 'spec_helper'

feature 'Home/Root page' do
  scenario "navigate to page" do
    visit root_url
    current_path.should == root_path
    find_link 'Ladyparts'
    find_link 'Bechdel Test API'
    find_link 'Rotten Tomatoes API'
    find_link '@enspencer'
    find_link '@plainpioneer'
    find_link 'our code on GitHub'
    click_button 'The Bechdel Test'
    click_button 'Explore films by critics score'
    click_button 'Explore films by director'
    find_link 'Dykes to Watch Out For'
    page.select '2004', from: 'json_sources'
    page.select 'directors with seven films passing', from: 'director_sources'
    click_button 'Color Key'
    # save_and_open_page
  end
end
