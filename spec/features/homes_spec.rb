require 'spec_helper'

feature 'Home/Root page' do
  scenario "without users" do
    visit root_url
    current_path.should == root_path
    find_link 'Bechdel Test API'
    find_link 'Rotten Tomatoes API'
    find_link 'our code on GitHub'
    find_link '@plainpioneer'
    find_link '@enspencer'
    find_link 'Ladyparts'
    find_link 'Dykes to Watch Out For'
    # still needs iframe testing for tweet button
    # within_frame 'twitter-widget-0' do
    # 	click_button 'Tweet Button'
    # end
    click_button 'The Bechdel Test'
    click_button 'Explore films by critics score'
    click_button 'Explore films by director'
    page.select 'directors with seven films passing', from: 'director_sources'
  end

end