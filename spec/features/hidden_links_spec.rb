require 'rails_helper'

feature 'hide and show links for project actions' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }

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
  end

end