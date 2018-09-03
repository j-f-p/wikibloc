class Collaborator < ApplicationRecord
  belongs_to :wiki
  belongs_to :user
  
  validates_associated :wiki
  validates_associated :user
  
  # belongs_to and validates_associated obviate the need for validates presence
  
  validates :user, uniqueness: { scope: :wiki,
    message: "ID corresponds to an existing collaborator. " +
      "Select ID from those available." }
end
