class List < ActiveRecord::Base
  attr_accessible :title

  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: { case_sensitivity: false }, length: { maximum: 50 }

  belongs_to :user
end
