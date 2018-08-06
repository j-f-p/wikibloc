require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) { create(:user, role: :premium) }
  let(:my_wiki) { create(:wiki) }
  
  context 'signed in premium user' do
    before do
      sign_in my_user
    end
    
    describe 'GET new' do
      it 'returns http success' do
        get :new, params: { wiki_id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end
      
      it 'renders the new view' do
        get :new, params: { wiki_id: my_wiki.id }
        expect(response).to render_template :new
      end
      
      it 'instantiates @collaborator' do
        get :new, params: { wiki_id: my_wiki.id }
        expect(assigns(:collaborator)).not_to be_nil
      end
    end
  end
end
