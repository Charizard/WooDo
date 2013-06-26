class Relationship < ActiveRecord::Base
  attr_accessible :list_id
  belongs_to :user
  belongs_to :list

  validates :user_id, presence: true
  validates :list_id, presence: true
end
