class Collaborator < ApplicationRecord
  belongs_to :wiki
  belongs_to :user
  
  validates_associated :wiki
  validates_associated :user
  
  validates :user, uniqueness: { scope: :wiki,
    message: "ID corresponds to an existing collaborator. " +
      "Select ID from those available." }
end
