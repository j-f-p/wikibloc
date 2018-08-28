require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki) }
  
  it { is_expected.to belong_to(:wiki) }
  it { is_expected.to belong_to(:user) }
  
  describe "belongs_to" do
    it "accepts defined wiki" do
      c = Collaborator.new(wiki_id: wiki.id, user: user)
      # for unknown reason, wiki.id worked but not 1 even though wiki.id==1
      expect(c.save!).to eq(true)
    end
    it "rejects undefined wiki" do
      c = Collaborator.new(wiki_id: 2, user: user)
      expect(c.save).to eq(false)
      # not save! so that exception not raised and false is registered
    end
    
    it "accepts defined user" do
      c = Collaborator.new(wiki: wiki, user_id: 1)
      expect(c.save!).to eq(true)
    end
    it "rejects undefined user" do
      c = Collaborator.new(wiki: wiki, user_id: 2)
      expect(c.save).to eq(false)
      # not save! so that exception not raised and false is registered
    end
  end
  
  describe "validates_associated" do
    it "rejects invalid associated wiki" do
      c = Collaborator.new(wiki: Wiki.new, user: user)
      expect(c.save).to eq(false)
    end
    
    it "rejects invalid associated user" do
      c = Collaborator.new(wiki: wiki, user: User.new)
      expect(c.save).to eq(false)
    end
  end
  
  # describe "validates uniqueness" do
  #   it "rejects repeat collaborator" do
  #     create(:collaborator, wiki: wiki, user: user)
  #     expect(create(:collaborator, wiki: wiki, user: user)).to eq(false)
  #   end
  # end
end
