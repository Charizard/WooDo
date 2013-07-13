# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#

class List < ActiveRecord::Base
  attr_accessible :title, :completed
  #before_filter :signed_in_user

  validates :title, presence: true, uniqueness: { case_sensitivity: false }, length: { maximum: 20 }

  has_many :tasks, :dependent => :destroy
  has_many :relationships, :dependent => :destroy
  has_many :users, through: :relationships

  def complete
    list.completed = true
    lists.tasks.each do |task|
      task.complete!
    end
  end

  private 
    def signed_in_user
      redirect_to root_url unless signed_in?
    end
end
