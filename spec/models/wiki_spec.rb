require 'rails_helper'

RSpec.describe Wiki, type: :model do
  it {  is_expected.to belong_to(:user) }
  
  let(:wiki) { create(:wiki) }
 
  describe "attributes" do
    it "has title, body and user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body,
        user: wiki.user)
    end
  end
end
