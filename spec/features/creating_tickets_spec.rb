require 'rails_helper'

feature 'Creating Tickets' do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    define_permission!(user, 'view', project)
    define_permission!(user, 'create tickets', project)
    @email = user.email
    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link 'New Ticket'
  end

  scenario 'Creating a ticket' do
    fill_in 'Title', with: 'Non-standarts compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'  

    expect(page).to have_content('Ticket has been created.')
    within '#ticket #author' do
      expect(page).to have_content("Created by #{@email}")
    end
  end

  scenario 'Creating a ticket without valid attributes fails' do
    click_button 'Create Ticket'  

    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")

  end

  scenario 'Description must be longer that 10 characters in order to be saved' do
    fill_in 'Title', with: 'Some cool feature'
    fill_in 'Description', with: 'Too short'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created.')
    expect(page).to have_content('Description is too short')
  end

  scenario 'Creating a ticket with an attachment', js: true do
    fill_in 'Title', with: 'Some another cool feature'
    fill_in 'Description', with: 'So cool new feature with attachment'

    attach_file 'File #1', Rails.root.join('spec/fixtures/speed.txt')
    click_link 'Add another file'
    attach_file 'File #2', Rails.root.join('spec/fixtures/spin.txt')

    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has been created')

    within('#ticket .assets') do
      expect(page).to have_content('speed.txt')
      expect(page).to have_content('spin.txt')
    end
  end
end
