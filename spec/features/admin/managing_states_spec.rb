require 'rails_helper'

feature 'Managing states' do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  before do
    load Rails.root + 'db/seeds.rb'
    sign_in_as!(admin)
    visit '/'
    click_link 'Admin'
    click_link 'States'
  end

  scenario 'Set state as default' do
    within state_line_for('New') do
      click_link 'Make Default'
    end

    expect(page).to have_content('New is now the default state')
  end
end