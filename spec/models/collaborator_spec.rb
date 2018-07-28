require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki) }
  let(:collaborator) { Collaborator.create!(user: user, wiki: wiki) }
  
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
end
