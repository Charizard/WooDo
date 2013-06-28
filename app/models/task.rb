class Task < ActiveRecord::Base
  attr_accessible :content
  belongs_to :list  

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }

  validates :content, presence: true, length: { maximum: 30 }
end
