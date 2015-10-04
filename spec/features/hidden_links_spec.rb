require 'rails_helper'

feature 'hide and show links for project actions' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context 'anonymous users' do
    scenario 'cannot see new project link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'cannot see edit project link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'cannot see delete project link' do
      visit project_path(project)
      assert_no_link_for 'Delete Project'
    end
  end

  context 'signed in users' do
    before { sign_in_as!(user) }
    scenario 'cannot see new project link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'cannot see edit project link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'cannot see delete project link' do
      visit project_path(project)
      assert_no_link_for 'Delete Project'
    end

    scenario 'New ticket link is shown to a user with permission' do
      define_permission!(user, 'view', project)
      define_permission!(user, 'create tickets', project)
      visit project_path(project)
      assert_link_for 'New Ticket'
    end

    scenario 'New ticket link is not shown to a user without permission' do
      define_permission!(user, 'view', project)
      visit project_path(project)
      assert_no_link_for 'New Ticket'
    end

    scenario 'Edit ticket link is shown to a user with permission' do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'edit tickets', project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'Edit ticket link is not shown to a user without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for 'Edit Ticket'
    end

    scenario 'Delete ticket link is shown to a user with permission' do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'delete tickets', project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end

    scenario 'Delete ticket link is not shown to a user without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for 'Delete Ticket'
    end
  end

  context 'signed in admins' do
    before { sign_in_as!(admin) }
    scenario 'can see new project link' do
      visit '/'
      assert_link_for 'New Project'
    end

    scenario 'can see edit project link' do
      visit project_path(project)
      assert_link_for 'Edit Project'
    end

    scenario 'can see delete project link' do
      visit project_path(project)
      assert_link_for 'Delete Project'
    end

    scenario 'can see new ticket link' do
      visit project_path(project)
      assert_link_for 'New Ticket'
    end

    scenario 'can see edit ticket link' do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'can see delete ticket link' do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end
  end

end