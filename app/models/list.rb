class List < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: true, uniqueness: { case_sensitivity: false }, length: { maximum: 20 }

  has_many :tasks
  has_many :relationships
  has_many :users, through: :relationships
end
