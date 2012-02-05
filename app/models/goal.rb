class Goal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :due, :created_at, :payment, :emails, :other, :state
end
