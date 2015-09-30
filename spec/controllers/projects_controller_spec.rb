require 'rails_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }

  it 'displays error for a missing project' do
    message = 'The project you were looking for could not be found.'
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eql(message)
  end

  context 'standard users' do
    before do
      sign_in(user)
    end

    {new: :get,
    create: :post,
    edit: :get,
    update: :put,
    destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        send(method, action, :id => FactoryGirl.create(:project))

        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql('You must be an admin to do that.')
      end
    end
  end

end
