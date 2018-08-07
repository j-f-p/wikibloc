class Collaborator < ApplicationRecord
  belongs_to :wiki
  belongs_to :user
  
  # belongs_to and validates_associated eliminates need for these
  # validates :wiki, presence: true
  # validates :user, presence: true
  
  validates_associated :wiki
  validates_associated :user
  
  validates :user, uniqueness: { scope: :wiki,
    message: "ID corresponds to an existing collaborator. " +
      "Select ID from those available." }
end
