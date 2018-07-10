require 'rails_helper'

RSpec.describe Wiki, type: :model do
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  # it { should validate_inclusion_of(:private).in_array([true, false]) }
    # works with warning to remove, thus removed. Validation works in app test.
  it { should validate_presence_of(:user) }
  
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:body).is_at_least(10) }
  
  let(:wiki) { create(:wiki) }
 
  describe "attributes" do
    it "has title, body, private and user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body,
        private: wiki.private, user: wiki.user)
    end
  end
end
