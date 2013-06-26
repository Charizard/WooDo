class Task < ActiveRecord::Base
  attr_accessible :content
  belongs_to :list  

  validates :content, presence: true, length: { maximum: 30 }
end
