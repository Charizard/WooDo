# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  list_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean          default(FALSE)
#  order_number :integer
#

class Task < ActiveRecord::Base
  attr_accessible :content, :order_number
  belongs_to :list  

  scope :completed, -> { where(completed: true).order('order_number ASC') }
  scope :pending, -> { where(completed: false).order('order_number ASC') }

  validates :content, presence: true, length: { maximum: 30 }
  validates :order_number, presence: true

end
