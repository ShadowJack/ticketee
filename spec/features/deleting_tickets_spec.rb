require 'rails_helper'

feature "Deleting tickets" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project) }

  scenario "Deleting a ticket" do
    visit "/"
    click_link project.name 
    click_link ticket.title
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been deleted.")
    expect(page.current_url).to eql(project_url(project))
    within('#tickets') do
      expect(page).to_not have_content(ticket.title)
    end
  end
end
