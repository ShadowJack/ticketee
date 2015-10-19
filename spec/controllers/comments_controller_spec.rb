require 'rails_helper'

describe CommentsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, name: 'Ticketee') }
  let(:ticket) { FactoryGirl.create(:ticket,
                                    user:        user,
                                    project:     project,
                                    title:       'State transitions',
                                    description: "Can't be hacked") }
  let(:state) { State.create!(name: 'New') }

  context 'a user without permission to set state' do
    before do
      sign_in(user)
    end

    it 'should cannot transition a state by passing through state_id' do
      post :create, { comment: { text: 'Hacked!', state_id: state.id },
                  ticket_id: ticket.id }
      ticket.reload
      expect(ticket.state).to eql(nil)
    end
  end
end