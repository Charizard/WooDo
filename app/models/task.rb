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
  attr_accessible :content, :order_number, :completed
  belongs_to :list  

  default_scope { order('order_number ASC') } 
  scope :completed, -> { where(completed: true).order('order_number ASC') }
  scope :pending, -> { where(completed: false).order('order_number ASC') }

  validates :content, presence: true, length: { maximum: 30 }
  validates :order_number, presence: true

  def complete
    self.complete = true
    self.save!
  end

  def self.change_order reorder
    reorder.each_with_index do |id, order|
      task = Task.find(id.to_i)
      task.order_number = order+1
      task.save
    end
  end
end
