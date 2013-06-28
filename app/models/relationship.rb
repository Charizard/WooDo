# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  list_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :list_id
  belongs_to :user
  belongs_to :list

  validates :user_id, presence: true
  validates :list_id, presence: true
end
