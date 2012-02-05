class Goal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :due, :created_at, :payment, :emails, :other, :state

  scope :pending, lambda { where("state = 'pending'") }
  scope :completed, lambda { where("state = 'failed' OR state = 'completed'") }

end
