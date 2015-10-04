require 'rails_helper'

describe TicketsController, type: :controller do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context 'standard users' do
    it 'cannot access a ticket for a project' do
      sign_in(user)
      get :show, id: ticket.id, project_id: project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql('The project you were looking for could not be found.')
    end

    context 'with permission to view the project' do
      before do
        sign_in(user)
        define_permission!(user, 'view', project)
      end

      def cannot_create_tickets!
        expect(response).to redirect_to(project)
        message = 'You cannot create tickets on this project.'
        expect(flash[:alert]).to eql(message)
      end

      def cannot_update_tickets!
        expect(response).to redirect_to(project)
        message = 'You cannot edit tickets on this project.'
        expect(flash[:alert]).to eql(message)
      end

      it 'cannot begin to create ticket' do
        get :new, project_id: project.id
        cannot_create_tickets!
      end

      it 'cannot create a ticket without permission' do
        post :create, project_id: project.id
        cannot_create_tickets!
      end

      it 'cannot begin to update ticket' do
        get :edit, id: ticket.id, project_id: project.id
        cannot_update_tickets!
      end

      it 'cannot update a ticket without permission' do
        put :update, id: ticket.id, project_id: project.id, ticket: {}
        cannot_update_tickets!
      end

      it 'cannot delete a ticket without permission' do
        delete :destroy, id: ticket.id, project_id: project.id

        expect(response).to redirect_to(project)
        message = 'You cannot delete tickets on this project.'
        expect(flash[:alert]).to eql(message)
      end
    end
  end
end
