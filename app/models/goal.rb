class Goal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :due, :created_at, :payment, :emails, :other, :state

  scope :pending, lambda { where("state = 'pending'") }
  scope :failed, lambda { where("state = 'failed' OR state = 'charged'") }
  scope :completed, lambda { where("state = 'completed'") }
  scope :done, lambda { where("state = 'failed' OR state = 'charged' OR state = 'completed'") }

end
