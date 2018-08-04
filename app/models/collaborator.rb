class Collaborator < ApplicationRecord
  belongs_to :wiki
  belongs_to :user
  
  validates :wiki, presence: true
  validates :user, presence: true
  
  validates_associated :wiki
  validates_associated :user
end
