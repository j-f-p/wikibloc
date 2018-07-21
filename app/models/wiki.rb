class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :helpers, through: :collaborators, source: :user
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validates :private, inclusion: { in: [ true, false ] }
  validates :user, presence: true
end
