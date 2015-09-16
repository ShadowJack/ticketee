require 'rails_helper'

describe ProjectsController do
  it 'displays error for a missing project' do
    message = 'The project you were looking for could not be found.'
    get :show, id: 'not-here'

    expect(response).to redirect_to(projects_path)
    expect(flash[:alert]).to eql(message) 
  end
end
