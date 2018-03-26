require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:my_user) { create(:user) }
  
  before do
    sign_in my_user
  end
  
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "generates instance hash variable stripe_btn_data with specified keys" do
      get :new
      expect(:stripe_btn_data).not_to be_nil
      expect(assigns(:stripe_btn_data)).to have_key :key
      expect(assigns(:stripe_btn_data)).to have_key :description
      expect(assigns(:stripe_btn_data)).to have_key :amount
    end
  end
end
