require 'rails_helper'

feature 'Adding new states' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin_user)
  end

  scenario 'Creating a state' do
    visit '/'
    click_link 'Admin'
    click_link 'States'
    click_link 'New State'
    fill_in 'Name', with: 'Duplicate'
    click_button 'Create State'

    expect(page).to have_content('State has been created')
  end
end