class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :wikis, dependent: :destroy
  enum role: [:standard, :premium, :admin]
  after_initialize :init
  
  attr_accessor :stripe_token
  def init
    self.role ||= :standard
  end
end
